import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_colors.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_urls.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/constants.dart';
import 'package:new_chatapp_chitchat/data/firebase_constants.dart';
import 'package:new_chatapp_chitchat/models/chat_user_model.dart';

class ChatUserCard extends StatefulWidget {
   final ChatUserModel user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
          EdgeInsets.symmetric(vertical: h! * 0.007, horizontal: w! * 0.007),
      elevation: 2,
      child: MaterialButton(
        onPressed: () {},
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(h!*0.2),
              child: CachedNetworkImage(
                  height: h! * 0.1,
                  width: w! * 0.14,
                  imageUrl: widget.user.image,
                  errorWidget: (context, url, error) =>
                    CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),
            ),
          ),
          title: Text(widget.user.name),
          subtitle: Text(widget.user.about),
          trailing:Container(width: w!*0.04,
          height: h!*0.02,
         
          decoration: BoxDecoration(
             color: AppColors.greencolor,
             borderRadius: BorderRadius.circular(50)),),
        ),
      ),
    );
  }
}
