import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_chatapp_chitchat/UIHelpers/dialogbox/dialog_box.dart';
import 'package:new_chatapp_chitchat/UIHelpers/dialogs/flushbar_plus_circularbar.dart';

import 'package:new_chatapp_chitchat/UIHelpers/mydate.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_colors.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/constants.dart';
import 'package:new_chatapp_chitchat/data/firebase_constants.dart';
import 'package:new_chatapp_chitchat/models/chat_user_model.dart';
import 'package:new_chatapp_chitchat/models/message_model.dart';
import 'package:new_chatapp_chitchat/view_models/chat_screen_provide.dart';
import 'package:provider/provider.dart';

class MessageBubble extends StatefulWidget {
  final MessageModel chats;
  //final ChatUserModel user;
  // bool isSelectedMessage;
  MessageBubble({
    super.key,
    required this.chats,
    // this.isSelectedMessage = false,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  Map<String, bool> messageStarStatus = {};

  bool isStarred = false;
  @override
  Widget build(BuildContext context) {
    messageStarStatus[widget.chats.sent] = true;

    bool ismyself = FbConstants.currentUser!.uid == widget.chats.sendBy;
    return Consumer<ChatScreenModelProvider>(
      builder: (context, chatScreenModelProvider, child) {
        return Container(
          color: chatScreenModelProvider.containsMessage(widget.chats) != -1
              ? Colors.green
              : null,
          child: InkWell(
            onLongPress: () {
              customModalBottomSheet(ismyself);
            },
            child: ismyself ? blueMessageBubble() : purpleMessageBubble(),
          ),
        );
      },
    );
  }

  Widget purpleMessageBubble() {
    final isMessageStarred = messageStarStatus[widget.chats.sent] ?? false;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(right: 100.0, left: 10),
        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (left) {
            FbConstants.deleteOthersMessage(widget.chats);
          },
          child: GestureDetector(
            onTap: () {
              FbConstants.starMessages(widget.chats);
              setState(() {
                isStarred = !isStarred;
              });
            },
            child: Container(
              padding: EdgeInsets.all(w! * 0.02),
              child: widget.chats.type == Type.text
                  ? widget.chats.isDeleteother
                      ? Text("MESSAGE DELETED",style: TextStyle(fontSize: 8),)
                      : Text(
                          widget.chats.msg,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )
                  : widget.chats.isDeleteother
                      ? Text("MESSAGE DELETED",style: TextStyle(fontSize: 8),)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(h! * 0.01),
                          child: CachedNetworkImage(
                            // height: h! * 0.15,
                            // width: w! * 0.13,
                            fit: BoxFit.fill,
                            imageUrl: widget.chats.msg,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const CircleAvatar(
                              child: Icon(Icons.image),
                            ),
                          ),
                        ),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  color: AppColors.purpleChatBubbleColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.2), // Shadow color with opacity
                      offset: const Offset(
                          2.0, 3.0), // Horizontal and vertical offset
                      blurRadius: 5.0, // Spread or blur radius
                      spreadRadius: 1.0, // Spread radius
                    ),
                  ],
                  border: Border.all(
                      color: const Color.fromARGB(236, 81, 36, 144))),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 18.0, top: 5, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              Mydate.formattedTime(context: context, time: widget.chats.sent),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
            // if (widget.chats.isStarred)
              // widget.chats.isStarred?InkWell(onTap: () {
              //    FbConstants.DoNotstarMessages(widget.chats);
                
              // },
              //   child: Icon(Icons.star,
              //     color: Color.fromARGB(255, 48, 174, 29),),
              // ):Icon(null),
              // IconButton(
              //   onPressed: () {
              //     FbConstants.DoNotstarMessages(widget.chats);
              //   },
              //   icon: Icon(Icons.star,color: const Color.fromARGB(0, 255, 193, 7),),
              
              // )
            
          ],
        ),
      )
    ]);
  }

  Widget blueMessageBubble() {
    if (widget.chats.read.isEmpty) {
      FbConstants.updateMessageStatus(widget.chats);
    }
    return Align(
      alignment: Alignment.bottomRight,
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 100),
          child: Dismissible(
            key: UniqueKey(),
            onDismissed: (left) {
              FbConstants.deleteMessage(widget.chats);
              //_showDeleteConfirmationDialog();
            },
            child: Container(
              padding: EdgeInsets.all(w! * 0.04),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    widget.chats.type == Type.text
                        ? widget.chats.isDeleted
                            ? Text('Message delete',style: TextStyle(fontSize: 8),)
                            : Text(
                                widget.chats.msg,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )
                        : widget.chats.isDeleted
                            ? Text("message deleted",style: TextStyle(fontSize: 8),)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(h! * 0.01),
                                child: CachedNetworkImage(
                                  // height: h! * 0.15,
                                  // width: w! * 0.13,
                                  fit: BoxFit.fill,
                                  imageUrl: widget.chats.msg,
                                  errorWidget: (context, url, error) =>
                                      const CircleAvatar(
                                    child: Icon(Icons.image),
                                  ),
                                ),
                              ),
                  ]),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                  color: AppColors.blueChatBubbleColor,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 36, 54, 128)
                          .withOpacity(0.2), // Shadow color with opacity
                      offset: const Offset(
                          2.0, 3.0), // Horizontal and vertical offset
                      blurRadius: 5.0, // Spread or blur radius
                      spreadRadius: 1.0, // Spread radius
                    ),
                  ],
                  border: Border.all(
                      color: const Color.fromARGB(236, 81, 36, 144))),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 5, bottom: 12),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text(
              Mydate.formattedTime(context: context, time: widget.chats.sent),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
            if (widget.chats.read.isNotEmpty)
              const Icon(
                Icons.done_all_rounded,
                color: Colors.blue,
              )
          ]),
        )
      ]),
    );
  }

  void customModalBottomSheet(bool _isMe) {
    bool _isStarred = false;
    //if (_isMe)
    showModalBottomSheet(
        backgroundColor: AppColors.primarycolor,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(40.0))),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Container(
                height: h! * 0.35,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: Text(
                        "Options",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: h! * 0.02,
                    ),
                    if (widget.chats.type == Type.text)
                      InkWell(
                        onTap: () async {
                          await Clipboard.setData(
                                  ClipboardData(text: widget.chats.msg))
                              .then((value) {
                            Navigator.pop(context);
                            UIHelpers.flushbarErrormessage(
                                "text copied to the clipboard", context);
                          });
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.copy,
                              color: AppColors.redcolor,
                            ),
                            Text(
                              "Copy Text",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: h! * 0.02,
                    ),
                    if (widget.chats.type == Type.text&& _isMe)
                      InkWell(
                        onTap: () {
                          {
                            Navigator.pop(context);
                            _showMessageUpdateDialog();
                            // FbConstants.updateMessage(widget.chats, updatedMsg);
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.edit,
                              color: AppColors.redcolor,
                            ),
                            Text(
                              "Update",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: h! * 0.02,
                    ),
                    if(!_isMe)
                    InkWell(
                      onTap: () {
                        debugPrint("Star Print");
                        FbConstants.starMessages(widget.chats);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          isStarred
                              ? Icon(Icons.star_outline_outlined)
                              : Icon(Icons.star_border_purple500_rounded),
                          Text(
                            "Star",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: h! * 0.02,
                    ),
                    if (_isMe)
                      InkWell(
                        onTap: () async {
                          _showDeleteConfirmationDialog();
                          //await FbConstants.deleteMessage(widget.chats)
                          //     .then((value) {
                          //   Navigator.pop(context);
                          // });
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.delete,
                              color: AppColors.redcolor,
                            ),
                            Text(
                              "Delete",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: h! * 0.02,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.pin,
                            color: AppColors.redcolor,
                          ),
                          Text(
                            "Pin",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  void _showMessageUpdateDialog() {
    String updatedMsg = widget.chats.msg;

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 10),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),

              //title
              title: const Row(
                children: [
                  Icon(
                    Icons.message,
                    color: Colors.blue,
                    size: 28,
                  ),
                  Text(' Update Message')
                ],
              ),

              //content
              content: TextFormField(
                initialValue: updatedMsg,
                maxLines: null,
                onChanged: (value) => updatedMsg = value,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),

              //actions
              actions: [
                MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    )),

                //update button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      Navigator.pop(context);
                      FbConstants.updateMessage(widget.chats, updatedMsg);
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ))
              ],
            ));
  }

  bool _confirmDelete = false; // Initialize to false

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content:
              Text('Are you sure you want to delete this message for evryone?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                FbConstants.deleteMessageForEveryone(
                    widget.chats, widget.chats);

                setState(() {
                  _confirmDelete = true;
                });
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );

    if (_confirmDelete) {
      setState(() {
        _confirmDelete = false;
      });
    }
  }
}
