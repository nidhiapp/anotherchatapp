import 'package:flutter/material.dart';
import 'package:new_chatapp_chitchat/UIHelpers/routes/routes_name.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_colors.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_images.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/constants.dart';
import 'package:new_chatapp_chitchat/res/methods_used.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        MethodsUsed.handleGoogleSignIn(context);
      
      },
      child: Stack(
        children: [
          Container(
            height: h! * 0.1,
            width: w! * 0.8,
            decoration: BoxDecoration(
                color: AppColors.primarycolor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.blackcolor, width: 2)),
          ),
          Positioned(
              left: w! * 0.07,
              child: Row(
                children: [
                  Image.asset(
                    AppImages.google,
                    height: h! * 0.1,
                    width: w! * 0.2,
                  ),
                  Text(
                    "Sign in with Google",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
