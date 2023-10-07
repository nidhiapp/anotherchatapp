
import 'package:flutter/material.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_colors.dart';

import 'package:new_chatapp_chitchat/UIHelpers/widgets/drawer_widget.dart/advance_switch.dart';

class cards extends StatelessWidget {
  bool togglexits;
  bool isOn;
  String text_1;
  String text_2;
  //Color color;
  String texts;
  IconData icons;
  cards({
    super.key,
    //  this.color = Colors.white,
    this.text_1 = "",
    this.texts = "",
    this.isOn = false,
    this.text_2 = "",
    this.icons = Icons.abc,
    this.togglexits = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        color:AppColors.primarycolor,
        height: 60,
        width: double.infinity,
        child: Row(
          children: [
            Icon(icons, size: 30, color: Color.fromARGB(255, 187, 65, 56)),
            SizedBox(
              width: 10,
            ),
            Text(
              texts,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            SizedBox(width: 80),
            Text(
              text_1,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            ),
            togglexits ? Advanceswitch(isOn: isOn,) : Text(""),
            Text(
              text_2,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
