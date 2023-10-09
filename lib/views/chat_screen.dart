import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_chatapp_chitchat/UIHelpers/mydate.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_colors.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/constants.dart';
import 'package:new_chatapp_chitchat/views/chat_user_info.dart';
import 'package:new_chatapp_chitchat/UIHelpers/widgets/components/message_bubble.dart';
import 'package:new_chatapp_chitchat/data/firebase_constants.dart';
import 'package:new_chatapp_chitchat/models/chat_user_model.dart';
import 'package:new_chatapp_chitchat/models/message_model.dart';

class ChatScreenView extends StatefulWidget {
  final ChatUserModel user;

  ChatScreenView({super.key, required this.user});

  @override
  State<ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> {
  //for storing all messages
  List<MessageModel> _list = [];
  //showing or not
  bool _emoji = false;
  String? _image;
  

  ScrollController _scrollController = ScrollController();
  TextEditingController _messageController = TextEditingController();
  ScrollController textEditingController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            if (_emoji) {
              setState(() {
                _emoji = !_emoji;
              });
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            backgroundColor: Color.fromARGB(237, 217, 222, 231),
            appBar: AppBar(
              // backgroundColor:
              automaticallyImplyLeading: false,
              flexibleSpace: _appBar(),
            ),
            body: Column(
              children: [
                Expanded(
                    child: StreamBuilder(
                        stream: FbConstants.getAllMessages(widget.user),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            //if data is loading
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return const Center(
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            //if some or all data is loaded then show it
                            case ConnectionState.active:
                            case ConnectionState.done:
                              final data = snapshot.data?.docs;

                              _list = data
                                      ?.map((e) =>
                                          MessageModel.fromJson(e.data()))
                                      .toList() ??
                                  [];

                              if (_list.isNotEmpty) {
                                return ListView.builder(
                                  controller: _scrollController,
                                  reverse: false,
                                  itemCount: _list.length,
                                  padding: EdgeInsets.only(top: 10),
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final messages = _list[index];
                                    return GestureDetector(
                                      onLongPress: () {
                                         setState(() {
                                 messages.isSelected = !messages.isSelected;
                                });

                                      },
                                      child: MessageBubble(chats: _list[index]),
                                    );

                                    
                                  },
                                );
                              } else {
                                return Center(
                                    child: Text(
                                  " say hi",
                                  style: TextStyle(fontSize: 20),
                                ));
                              }
                          }
                        })),
                chatBox(),
                if (_emoji)
                  SizedBox(
                      height: h! * 0.3,
                      child: EmojiPicker(
                        textEditingController: _messageController,
                        config: Config(
                          columns: 7,
                          emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                        ),
                      ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget chatBox() {
    return Container(
      decoration: BoxDecoration(color: AppColors.appBarColor1),
      child: Row(
        children: [
          Container(
            width: w! * 0.82,
            child: TextFormField(
              onFieldSubmitted: (String messsage) {
                if (_messageController.text.trim().isNotEmpty) {
                  FbConstants.sendMessages(
                      widget.user, _messageController.text.trim(), Type.text);
                  _messageController.clear(); // Clear the text field
                }
              },
              focusNode: FocusNode(),
              keyboardType: TextInputType.text,
              maxLines: null,
              controller: _messageController,
              decoration: InputDecoration(
                focusColor: Colors.blue,
                hintText: "Type something ....",
                border: InputBorder.none,
                hintStyle: TextStyle(color: AppColors.whitecolor),
                prefixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      if (_emoji) _emoji = !_emoji;
                    });
                  },
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        FocusScope.of(context).unfocus();
                        _emoji = !_emoji;
                      });
                    },
                    child: Icon(
                      Icons.emoji_emotions_rounded,
                      color: Color.fromARGB(255, 27, 59, 74),
                    ),
                  ),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    bottomSheet();
                  },
                  child: Icon(
                    Icons.image,
                    color: AppColors.whitecolor,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                if (_messageController.text.trim().isNotEmpty) {
                  FbConstants.sendMessages(
                      widget.user,
                      _messageController.text.trim(),
                      Type.text // Trim leading/trailing whitespace
                      );
                  _messageController.clear(); // Clear the text field
                }
                _scrollToBottom();
              },
              icon: CircleAvatar(
                child: Icon(
                  Icons.send,
                  color: AppColors.blackcolor,
                ),
              )),
        ],
      ),
    );
  }

  Widget _appBar() {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.appBarColor1, AppColors.appBarColor2])),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FriendsProfileInfo(
                          user: widget.user,
                        )));
          },
          child: StreamBuilder(
              stream: FbConstants.usersInfo(widget.user),
              builder: ((context, snapshot) {
                final data = snapshot.data?.docs;

                final list = data
                        ?.map((e) => ChatUserModel.fromJson(e.data()))
                        .toList() ??
                    [];

                return Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => FriendsProfileInfo(user: widget.user,)));

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(h! * 0.4),
                          child: CachedNetworkImage(
                            height: h! * 0.15,
                            width: w! * 0.13,
                            fit: BoxFit.fill,
                            imageUrl: list.isNotEmpty
                                ? list[0].image
                                : widget.user.image,
                            errorWidget: (context, url, error) => CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: w! * 0.1,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            list.isNotEmpty ? list[0].name : widget.user.name,
                            style: TextStyle(
                                color: AppColors.chatUserTitleColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 0.02,
                        ),
                        Text(
                          list.isNotEmpty
                              ? list[0].isOnline
                                  ? 'Online'
                                  : Mydate.getLastActiveTime(
                                      context: context,
                                      lastActive: widget.user.lastActive)
                              : Mydate.getLastActiveTime(
                                  context: context,
                                  lastActive: widget.user.lastActive),
                          style: TextStyle(
                              color: AppColors.chatUserTitleColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                );
              })),
        ));
  }

  void bottomSheet() {
   
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(40.0))),
        builder: (context) {
          return Container(
            height: h! * 0.2,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    "Pick Your Profile Image",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: h! * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
// Pick an image.
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.camera, imageQuality: 80);

                          if (image != null) {
                            debugPrint(
                                'Image Path: ${image.path}----- Mime Type:${image.mimeType}');
                            // setState(() {
                            //   _image = image.path;
                            // });
                            FbConstants.sendChatImage(
                                widget.user, File(image.path));

                            Navigator.pop(context);
                          }
                        },
                        child: Column(
                          children: [
                            const Icon(
                              Icons.camera,
                              color: Color.fromARGB(246, 121, 39, 39),
                              size: 40,
                            ),
                            Text("camera")
                          ],
                        )),
                    SizedBox(
                      width: w! * 0.3,
                    ),
                    InkWell(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
// Pick an image.
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 80);

                        if (image != null) {
                          debugPrint(
                              'Image Path: ${image.path}----- Mime Type:${image.mimeType}');
                          // setState(() {
                          //   _image = image.path;
                          // });
                          FbConstants.sendChatImage(
                              widget.user, File(image.path));

                          Navigator.pop(context);
                        }
                      },
                      child: Column(
                        children: [
                          const Icon(
                            Icons.image,
                            color: Color.fromARGB(246, 121, 39, 39),
                            size: 40,
                          ),
                          Text("Gallery")
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
