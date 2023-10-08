import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_chatapp_chitchat/UIHelpers/routes/routes_name.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_colors.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_texts.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/constants.dart';
import 'package:new_chatapp_chitchat/UIHelpers/widgets/components/chat_user_cards.dart';
import 'package:new_chatapp_chitchat/UIHelpers/widgets/drawer_widget.dart/complete_drawer_integration.dart';

import 'package:new_chatapp_chitchat/data/firebase_constants.dart';
import 'package:new_chatapp_chitchat/models/chat_user_model.dart';
import 'package:new_chatapp_chitchat/views/chat_screen.dart';


import 'package:new_chatapp_chitchat/views/profile_page.dart';
import 'package:provider/provider.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final List<ChatUserModel> _searchList = [];

  List<ChatUserModel> _list = [];

  bool _isSearching = false;

  @override
  void initState() {
    FbConstants.getSelfInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: !_isSearching
                ? Text(
                    AppTexts.letschat,
                    style: TextStyle(color: Colors.black),
                  )
                : TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "name, email",
                    ),
                    autofocus: true,
                    onChanged: (value) {
  _searchList.clear();
  for (var i in _list) {
    if (i.name.toLowerCase().contains(value.toLowerCase()) ||
        i.email.toLowerCase().contains(value.toLowerCase())) {
      _searchList.add(i);
    }
  }
  print("Search Query: $value");
  print("Search List Length: ${_searchList.length}");
  setState(() {
    // Update the widget with the new search results
  });
},

                  ),
            backgroundColor: AppColors.whitecolor,
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                    });
                  },
                  icon: Icon(_isSearching
                      ? Icons.cancel_rounded
                      :Icons.search)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Profilepage(user: FbConstants.myself)));
                  },
                  icon: Icon(Icons.more_vert))
            ],
          ),
          drawerScrimColor: Colors.transparent,
          drawer: CompleteDrawerIntegeration(),
          floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: InkWell(onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreenView(user: )));
              },
                child: Icon(
                  Icons.add_comment_outlined,
                ),
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
                    _list = data
                            ?.map((e) => ChatUserModel.fromJson(e.data()))
                            .toList() ??
                        [];

                    if (_list.isNotEmpty) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return ChatUserCard(
                            user: _isSearching
                                ? _searchList[index]
                                : _list[index],
                          );
                        },
                        padding: EdgeInsets.only(top: h! * 0.002),
                        physics: BouncingScrollPhysics(),
                        itemCount:
                            _isSearching ? _searchList.length : _list.length,
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
        ),
      ),
    );
  }
}
