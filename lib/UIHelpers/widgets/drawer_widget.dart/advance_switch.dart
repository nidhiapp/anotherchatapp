import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';


class Advanceswitch extends StatefulWidget {
  Advanceswitch(
      {super.key,
      this.ac_color = Colors.amber,
      this.in_color = Colors.red,
      this.ltext = "on",
      this.rtext = "off",
      this.isOn = false,});
  String ltext;
  String rtext;
  Color ac_color;
  Color in_color;
  bool isOn;

  @override
  State<Advanceswitch> createState() => _AdvanceswitchState();
}

class _AdvanceswitchState extends State<Advanceswitch> {
  final _controller = ValueNotifier<bool>(true);
  Color _color = Colors.black;
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AdvancedSwitch(
        controller: _controller,
        enabled: true,
        height: 25,
        width: 45,
        borderRadius: BorderRadius.circular(20),
        inactiveColor: widget.in_color,
        activeColor: widget.ac_color,
        
        activeChild: widget.isOn?Text(
          widget.ltext,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        ):Text(""),
       
        inactiveChild: widget.isOn?Text(
          widget.rtext,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        ):Text("")
      ),
    );
  }
}
