import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_chatapp_chitchat/UIHelpers/routes/routes_name.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_colors.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/constants.dart';
import 'package:new_chatapp_chitchat/data/firebase_constants.dart';
import 'package:new_chatapp_chitchat/views/home_Screen.dart';

import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      if (FbConstants.auth.currentUser != null) {
        debugPrint('\nUser:${FbConstants.auth.currentUser!}');
        debugPrint('\nUseradditionalinfo:${FirebaseAuth.instance.currentUser!}');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreenView()));

        //Navigator.pushNamed(context, RoutesName.home);
      } else {
        Navigator.pushNamed(context, RoutesName.login);
      }

      // if (FirebaseAuth.instance.currentUser! != null) {
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, RoutesName.home, ((route) => false));
      // } else {
      //   Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, ((route) => false));
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 62, 90),
      body: Center(
        child: Container(
          //color: const Color.fromARGB(255, 250, 232, 178),

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image.asset(
                //   "assets/images/chatgif.gif",
                //   height: h! * 0.3,
                // ),
                Text(
                  " Welcome to the ChatApp",
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: AppColors.blackcolor,
                        offset: Offset(2, 2),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
