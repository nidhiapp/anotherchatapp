import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_chatapp_chitchat/UIHelpers/mydate.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_colors.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_urls.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/constants.dart';
import 'package:new_chatapp_chitchat/data/firebase_constants.dart';
import 'package:new_chatapp_chitchat/models/chat_user_model.dart';
import 'package:new_chatapp_chitchat/models/message_model.dart';
import 'package:new_chatapp_chitchat/views/chat_screen.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUserModel user;

  ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  MessageModel? _lastmessage;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
          EdgeInsets.symmetric(vertical: h! * 0.007, horizontal: w! * 0.007),
      elevation: 2,
      child: MaterialButton(
        onPressed: () {},
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreenView(user: widget.user)));
            },
            child: StreamBuilder(
                stream: FbConstants.getLastMesasge(widget.user),
                builder: (context, snapshot) {
                  final data = snapshot.data?.docs;
                 
                       final     list = data
                                    ?.map((e) => MessageModel.fromJson(e.data()))
                                    .toList() ??
                                [];
                  if (list.isNotEmpty) {
                    _lastmessage = list[0];
                  }

                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(h! * 0.2),
                        child: CachedNetworkImage(
                          height: h! * 0.1,
                          width: w! * 0.14,
                          imageUrl: widget.user.image,
                          errorWidget: (context, url, error) => CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                        ),
                      ),
                    ),
                    title: Text(widget.user.name),
                    subtitle: Text(_lastmessage != null? _lastmessage!.type==Type.image?'image':
                        _lastmessage!.msg
                        : widget.user.about,
                        maxLines: 1,),
                    trailing:_lastmessage==null?
                     null:
                     _lastmessage!.read.isEmpty && _lastmessage!.sendBy != FbConstants.currentUser.uid? Container(
                      width: w! * 0.04,
                      height: h! * 0.02,
                      decoration: BoxDecoration(
                          color: AppColors.greencolor,
                          borderRadius: BorderRadius.circular(50)),
                    ):

                    Padding(
                      padding: const EdgeInsets.only(left:15.0),
                      child: Column(
                        children: [Text("Last seen",style: TextStyle(fontSize:15 ,
                        color: Color.fromARGB(121, 92, 56, 44),fontWeight: FontWeight.w500),),
                          Text(Mydate.getLastMessageTime(context: context, time: _lastmessage!.sent),
                          style: TextStyle(fontSize: 13),),
                        ],
                      ),
                    )
                  );
                })),
      ),
    );
  }
}
