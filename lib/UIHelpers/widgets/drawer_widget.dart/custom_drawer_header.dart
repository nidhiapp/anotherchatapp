import 'package:flutter/material.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_colors.dart';
class CustomDrawerHeader extends StatefulWidget {
  const CustomDrawerHeader({super.key});

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
        color: Color.fromARGB(170, 68, 88, 123),
        borderRadius: BorderRadius.only(
         // topLeft: Radius.circular(20),
          topRight: Radius.circular(20))),
      padding: const EdgeInsets.only(top:30),
       
      child: const Padding(
        padding: EdgeInsets.only(bottom:15.0,right: 15.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(Icons.settings,size: 30,),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(radius: 30,child: Icon(Icons.person),
                ),
                  SizedBox(width:20),
                  Column(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("rida",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                      Row(
                        children: [
                          Text(" ",),Icon(Icons.star_rounded,size: 20,color: Colors.amber,)
                        ],
                      ), 
                    ],
                  )
                // Container(height: 70,
                // margin: EdgeInsets.only(bottom: 10),
                // decoration: BoxDecoration(
                //   shape: BoxShape.circle,
                //   image: DecorationImage(
                //     image: AssetImage('assets/images/profile.png'))),),
              ],
            ),
          ),
        
        ]),
      ),
    );
  }
}