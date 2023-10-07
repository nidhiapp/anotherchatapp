import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UIHelpers {
  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static void flushbarErrormessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          borderRadius: BorderRadius.circular(20),
          message: message,
          title: "alert",
          forwardAnimationCurve: Curves.decelerate,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: EdgeInsets.all(15),
          icon: Icon(Icons.error),
          backgroundColor: Color.fromARGB(255, 127, 124, 238),
          duration: Duration(seconds: 2),
          flushbarPosition: FlushbarPosition.TOP,
        )..show(context));
  }
  static void showProgressBar(BuildContext context){
    showDialog(context: context, builder: (_)=>
      Center(child: CircularProgressIndicator())

    );
  }
}