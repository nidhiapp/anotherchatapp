import 'package:flutter/material.dart';
import 'package:new_chatapp_chitchat/UIHelpers/dialogs/flushbar_plus_circularbar.dart';
import 'package:new_chatapp_chitchat/UIHelpers/routes/routes_name.dart';
import 'package:new_chatapp_chitchat/data/auth_services.dart';
import 'package:new_chatapp_chitchat/data/firebase_constants.dart';

class MethodsUsed {
  static handleGoogleSignIn(BuildContext context) {
    UIHelpers.showProgressBar(context);
    AuthServices.signInWithGoogle().then((user) async {
      Navigator.pop(context);
      if (user != null) {
        debugPrint('\nUser:${user.user}');
        debugPrint('\nUseradditionalinfo:${user.additionalUserInfo}');
        if ((await FbConstants.userExists())) {
          Navigator.pushNamed(
            context,
            RoutesName.home,
          );
        } else {
          FbConstants.createUser().then((value) {
            Navigator.pushNamed(
              context,
              RoutesName.home,
            );
          });
        }
      }
    });
  }
}
