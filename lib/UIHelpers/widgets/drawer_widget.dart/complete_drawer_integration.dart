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
                children: [Container(
      // color: Color.fromARGB(255, 200, 146, 76),
      width: double.infinity,
      height: 170,
      decoration: const BoxDecoration(
          color: Color.fromARGB(101, 7, 105, 151),
          borderRadius: BorderRadius.only(
              // topLeft: Radius.circular(20),
              topRight: Radius.circular(20))),
      padding: const EdgeInsets.only(top: 30),

      child: const Padding(
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
                          "rida",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
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