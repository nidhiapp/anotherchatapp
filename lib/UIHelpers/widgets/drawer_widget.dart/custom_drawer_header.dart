import 'package:flutter/material.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_colors.dart';
import 'package:new_chatapp_chitchat/models/chat_user_model.dart';

class CustomDrawerHeader extends StatefulWidget {
  const CustomDrawerHeader({super.key,required this.user});
 final ChatUserModel user;

  @override
  State<CustomDrawerHeader> createState() => _CustomDrawerHeaderState();
}

class _CustomDrawerHeaderState extends State<CustomDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color.fromARGB(255, 200, 146, 76),
      width: double.infinity,
      height: 170,
      decoration: const BoxDecoration(
          color: Color.fromARGB(101, 7, 105, 151),
          borderRadius: BorderRadius.only(
              // topLeft: Radius.circular(20),
              topRight: Radius.circular(20))),
      padding: const EdgeInsets.only(top: 30),

      child:  Padding(
        padding: EdgeInsets.only(bottom: 15.0, right: 15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.settings,
                size: 30,
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person),
                    ),
                    SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Explore the World, One Drawer at a Time.",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                        Row(
                          children: [
                            Text(
                              " ",
                            ),
                            Icon(
                              Icons.star_rounded,
                              size: 20,
                              color: Colors.amber,
                            )
                          ],
                        ),
                      ],
                    )
                  
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
