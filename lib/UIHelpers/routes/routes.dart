import 'package:flutter/material.dart';
import 'package:new_chatapp_chitchat/UIHelpers/routes/routes_name.dart';
import 'package:new_chatapp_chitchat/views/home_Screen.dart';
import 'package:new_chatapp_chitchat/views/login_view.dart';
import 'package:new_chatapp_chitchat/views/sign_up_view.dart';

class Routes {
  static MaterialPageRoute<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
       case RoutesName.signup:
        return MaterialPageRoute(builder: (context) => SignUpView()); 
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => LoginView());
        
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => HomeScreenView());  
      default:
        return MaterialPageRoute(builder: (context) {
          return Scaffold(
            body: Container(
              child: Center(child: Text("no route is defined")),
            ),
          );
        });
    }
  }
}
