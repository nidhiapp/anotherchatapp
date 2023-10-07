import 'package:flutter/material.dart';
import 'package:new_chatapp_chitchat/UIHelpers/widgets/custom_round_button.dart';
import 'package:new_chatapp_chitchat/UIHelpers/widgets/custom_textfield.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
              ),
              Text("User Name"),
              CustomTextFormField(
                hintext: " Enter Name",
              ),
              Text("email"),
              CustomTextFormField(
                hintext: "email",
              ),
              Text("password"),
              CustomTextFormField(
                hintext: "password",
              ),
              CustomTextFormField(
                hintext: "confirm password",
              ),
              RoundButton(title: "signup", onpress: () {})
            ],
          ),
        ),
      ),
    );
  }
}
