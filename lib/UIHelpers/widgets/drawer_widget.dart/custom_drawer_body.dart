import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_chatapp_chitchat/UIHelpers/dialogs/flushbar_plus_circularbar.dart';
import 'package:new_chatapp_chitchat/UIHelpers/routes/routes_name.dart';
import 'package:new_chatapp_chitchat/UIHelpers/widgets/drawer_widget.dart/drawer_cards.dart';
import 'package:new_chatapp_chitchat/data/firebase_constants.dart';
import 'package:new_chatapp_chitchat/models/chat_user_model.dart';
import 'package:new_chatapp_chitchat/views/profile_page.dart';

class CustomDrawerBody extends StatelessWidget {
  List<Widget> callcard = [];
  List<ChatUserModel> list = [];
  CustomDrawerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MaterialButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Profilepage(user: FbConstants.myself)));
          },
          child: cards(
            icons: Icons.person_2_outlined,
            texts: "My Profile",
          ),
        ),
        MaterialButton(
          onPressed: () {},
          child: cards(
            icons: Icons.notifications_outlined,
            texts: "Notifications",
          ),
        ),
        MaterialButton(onPressed: () {
          
        },
          child: cards(
            icons: Icons.language_outlined,
            texts: "Language",
            text_1: "Eng ",
            togglexits: true,
            text_2: " Arabic",
          ),
        ),
        MaterialButton(
          onPressed: () async {
            if (FbConstants.auth.currentUser != null) {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, RoutesName.login, (route) => false);
              //     FbConstants.auth = FirebaseAuth.instance;
              // Navigator.pushReplacementNamed(context, RoutesName.login);
              // Navigator.pop(context);
              await FbConstants.auth.signOut();
              await GoogleSignIn().signOut();
              await FbConstants.updateActiveStatus(false);
              // ignore: use_build_context_synchronously
              bool confirmLogout = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm Log Out'),
                      content: const Text('Are you sure you want to log out?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                            UIHelpers.showProgressBar(context);
                            // UIHelpers.showProgressBar(context).then
                            // User confirmed log out
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pop(false); // User canceled log out
                          },
                          child: const Text('No'),
                        ),
                      ],
                    );
                  });
            }
          },
          child: cards(
            icons: Icons.logout_outlined,
            texts: "Log Out",
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
