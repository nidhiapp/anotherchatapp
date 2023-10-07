import 'package:flutter/material.dart';
import 'package:new_chatapp_chitchat/UIHelpers/routes/routes_name.dart';
import 'package:new_chatapp_chitchat/views/home_Screen.dart';
import 'package:new_chatapp_chitchat/views/login_view.dart';
import 'package:new_chatapp_chitchat/views/profile_page.dart';
import 'package:new_chatapp_chitchat/views/sign_up_view.dart';
import 'package:new_chatapp_chitchat/views/splash.dart';

class Routes {
  static MaterialPageRoute<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => SplashView());
        
       case RoutesName.signup:
        return MaterialPageRoute(builder: (context) => SignUpView()); 
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => LoginView());
        
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => HomeScreenView());

      
      // case RoutesName.profile:
       
      //   return MaterialPageRoute(builder: (context) => Profilepage(u));  
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
