import 'package:flutter/material.dart';
import 'package:new_chatapp_chitchat/UIHelpers/widgets/drawer_widget.dart/custom_drawer_body.dart';
import 'package:new_chatapp_chitchat/UIHelpers/widgets/drawer_widget.dart/custom_drawer_header.dart';

class CompleteDrawerIntegeration extends StatefulWidget {
  const CompleteDrawerIntegeration({super.key});

  @override
  State<CompleteDrawerIntegeration> createState() => _CompleteDrawerIntegerationState();
}

class _CompleteDrawerIntegerationState extends State<CompleteDrawerIntegeration> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
            padding: const EdgeInsets.only(top:50.0),
            child: ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
              child: Drawer(
                
                

                backgroundColor:Color.fromARGB(255, 211, 198, 198) ,
                
              child: Column(
                children: [CustomDrawerHeader(
                  
                ),
                Container(height: 400,width:double.infinity,
                  child: CustomDrawerBody(
                    
                  )),
                  SizedBox(height: 60,),
                   Align(alignment: Alignment.bottomCenter,
              child: Text("App version 4.18.2(1)",style: TextStyle(fontWeight: FontWeight.w500),
              )
              )
                  ],
              ),
              ),
            ),
          );
  }
}