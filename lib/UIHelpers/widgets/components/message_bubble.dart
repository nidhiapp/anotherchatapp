import 'package:flutter/material.dart';

import 'package:new_chatapp_chitchat/UIHelpers/mydate.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_colors.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/constants.dart';
import 'package:new_chatapp_chitchat/data/firebase_constants.dart';
import 'package:new_chatapp_chitchat/models/message_model.dart';

class MessageBubble extends StatefulWidget {
  final MessageModel chats;
  MessageBubble({super.key, required this.chats});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    return FbConstants.currentUser.uid == widget.chats.sendBy
        ? blueMessageBubble()
        : purpleMessageBubble();
  }

  Widget purpleMessageBubble() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(right: 100.0, left: 10),
        child: Container(
          padding: EdgeInsets.all(w! * 0.02),
          child: Text(
            widget.chats.msg,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              color: AppColors.purpleChatBubbleColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.2), // Shadow color with opacity
                  offset: Offset(2.0, 3.0), // Horizontal and vertical offset
                  blurRadius: 5.0, // Spread or blur radius
                  spreadRadius: 1.0, // Spread radius
                ),
              ],
              border: Border.all(color: Color.fromARGB(236, 81, 36, 144))),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 18.0, top: 5, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              Mydate.formattedTime(context: context, time: widget.chats.sent),
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      )
    ]);
  }

  Widget blueMessageBubble() {
    if (widget.chats.read.isNotEmpty) {
      FbConstants.updateMessageStatus(widget.chats);
    }
    return Align(
      alignment: Alignment.bottomRight,
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 100),
          child: Container(
            padding: EdgeInsets.all(w! * 0.04),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.chats.msg,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ]),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
                color: AppColors.blueChatBubbleColor,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 36, 54, 128)
                        .withOpacity(0.2), // Shadow color with opacity
                    offset: Offset(2.0, 3.0), // Horizontal and vertical offset
                    blurRadius: 5.0, // Spread or blur radius
                    spreadRadius: 1.0, // Spread radius
                  ),
                ],
                border: Border.all(color: Color.fromARGB(236, 81, 36, 144))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 5, bottom: 12),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text(
              Mydate.formattedTime(context: context, time: widget.chats.sent),
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
            if (widget.chats.read.isNotEmpty)
              Icon(
                Icons.done_all_rounded,
                color: Colors.blue,
              )
          ]),
        )
      ]),
    );
  }
}
