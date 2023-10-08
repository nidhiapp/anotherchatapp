import 'package:flutter/material.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_colors.dart';


class RoundButton extends StatelessWidget {
  final String title;
  bool loading;
  final VoidCallback onpress;

  RoundButton(
      {super.key,
      required this.title,
      this.loading = false,
      required this.onpress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onpress,
        child: Container(
          width: 150,
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.primarycolor),
          child: Center(
              child: loading
                  ? CircularProgressIndicator()
                  : Text(
                      title,
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.whitecolor,
                          fontWeight: FontWeight.w500),
                    )),
        ));
  }
}
