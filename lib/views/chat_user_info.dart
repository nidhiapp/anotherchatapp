import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_chatapp_chitchat/UIHelpers/mydate.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_colors.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/constants.dart';
import 'package:new_chatapp_chitchat/models/chat_user_model.dart';

class FriendsProfileInfo extends StatefulWidget {
  final ChatUserModel user;
  FriendsProfileInfo({super.key, required this.user});
 

  @override
  State<FriendsProfileInfo> createState() => _FriendsProfileInfoState();
}

class _FriendsProfileInfoState extends State<FriendsProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
            ),
            body: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 65, left: 15, right: 15),
                    height: h! * 0.5,
                    //color: Color.fromARGB(255, 221, 177, 174),
                    decoration: BoxDecoration(
                        color: AppColors.primarycolor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        //  crossAxisAlignment: CrossAxisAlignment.,

                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Center(
                                        child: Text(
                                  "  My Profile",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700),
                                ))),
                                CircleAvatar(
                                    radius: 20,
                                    backgroundColor:
                                        Color.fromARGB(255, 75, 122, 100),
                                    child: Icon(
                                      Icons.person_3_outlined,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child:ClipRRect(
                          borderRadius: BorderRadius.circular(h! * 0.4),
                          child: CachedNetworkImage(
                            height: h! * 0.2,
                            width: w! * 0.4,
                            fit: BoxFit.fill,
                            imageUrl: 
                                
                               widget.user.image,
                            errorWidget: (context, url, error) => CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                          ),
                        ),
                          ),
                          SizedBox(
                            height: h! * 0.04,
                          ),
                          Text(
                            widget.user.name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                           height: h! * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.email_outlined,
                                size: 20,
                                color: AppColors.redcolor,
                              ),
                              Text(
                            widget.user.email,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ],

                            //   SizedBox(height: h!*0.3,),
                          ),
                           SizedBox(
                            height: h! * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.info,
                                size: 20,
                                color: AppColors.redcolor,
                              ),
                              Text(
                            widget.user.about,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ],

                            //   SizedBox(height: h!*0.3,),
                          ),
                        ])),
                SizedBox(
                  height: h! * 0.2,
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("joined On : ",style: TextStyle(color: AppColors.redcolor,
                        fontSize: 15,fontWeight: FontWeight.bold),),
                        SizedBox(width: w!*0.02,),
                        Text(Mydate.getLastMessageTime(context: context, time: widget.user.createdAt,showYear: true),
                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),)
                      ],
                    ))
              ],
            )));
  }
}
