




import 'package:flutter/material.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_colors.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_images.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_texts.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/constants.dart';
import 'package:new_chatapp_chitchat/UIHelpers/widgets/custom_textfield.dart';
import 'package:new_chatapp_chitchat/UIHelpers/widgets/google_sign_in_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool login = false;
  String email = "";
   String password = "";
    String fullname = "";
    final _formKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppTexts.welcometoletschat,
            style: TextStyle(color: AppColors.blackcolor),
          ),
          backgroundColor: AppColors.whitecolor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.chitchat),
        
            Center(child: GoogleSignInButton()),
          ],
        ));
  }
}
