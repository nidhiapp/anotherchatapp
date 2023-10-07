import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_chatapp_chitchat/UIHelpers/routes/routes_name.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_colors.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_texts.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/constants.dart';
import 'package:new_chatapp_chitchat/UIHelpers/widgets/chat_user_cards.dart';
import 'package:new_chatapp_chitchat/UIHelpers/widgets/drawer_widget.dart/complete_drawer_integration.dart';
import 'package:new_chatapp_chitchat/UIHelpers/widgets/drawer_widget.dart/custom_drawer_body.dart';
import 'package:new_chatapp_chitchat/UIHelpers/widgets/drawer_widget.dart/custom_drawer_header.dart';
import 'package:new_chatapp_chitchat/data/firebase_constants.dart';
import 'package:new_chatapp_chitchat/models/chat_user_model.dart';
import 'package:new_chatapp_chitchat/views/profile_page.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  List<ChatUserModel> list = [];

  @override
  void initState() {
    FbConstants.getSelfInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppTexts.letschat,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: AppColors.whitecolor,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profilepage(user:FbConstants.myself)));
              },
              icon: Icon(Icons.more_vert))
        ],
      ),
      drawerScrimColor: Colors.transparent,
      drawer: CompleteDrawerIntegeration(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.add_comment_outlined,
          )),
      body: StreamBuilder(
          stream: FbConstants.getAllUsers(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              //if data is loading
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(
                  child: Center(child: CircularProgressIndicator()),
                );
              //if some or all data is loaded then show it
              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                list = data
                        ?.map((e) => ChatUserModel.fromJson(e.data()))
                        .toList() ??
                    [];

                if (list.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return ChatUserCard(
                        user: list[index],
                      );
                    },
                    padding: EdgeInsets.only(top: h! * 0.002),
                    physics: BouncingScrollPhysics(),
                    itemCount: list.length,
                  );
                } else {
                  return Center(
                      child: Text(
                    "No connection found",
                    style: TextStyle(fontSize: 20),
                  ));
                }
            }
          }),
    );
  }
}
