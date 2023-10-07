import 'package:flutter/material.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_colors.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_texts.dart';
class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(leading: Icon(Icons.menu,color:AppColors.blackcolor,),
      title: Text(AppTexts.letschat,
    style: TextStyle(color: Colors.black),),
    backgroundColor:AppColors.whitecolor,
    actions: [IconButton(onPressed: (){

    }, icon: Icon(Icons.search))],),

    floatingActionButton: FloatingActionButton(onPressed: (){

    },
    child: Icon(Icons.add_comment_outlined,)),

    );
  }
}