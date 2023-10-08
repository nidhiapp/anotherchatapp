import 'package:flutter/material.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_colors.dart';


class CustomTextFormField extends StatefulWidget {
  String hintext;
  String labeltexts;
  TextEditingController? customController;
  IconData? prefixicon;
  IconData? suffixicon;
  String? obscuretext;
  bool isobscureText;
  final FocusNode? focusNode;
  TextInputType? keyboardType;
  final ValueChanged<String>? onFieldSubmitted;
  IconData? icons;
  dynamic customValidator;
  String? passwordToMatch;

  CustomTextFormField({
    super.key,
    this.hintext = "",
    this.labeltexts = "",
    this.prefixicon,
    this.suffixicon,
    this.obscuretext,
    this.isobscureText = false,
    this.keyboardType,
    this.focusNode,
    this.onFieldSubmitted,
    this.icons,
    this.customController,
    this.customValidator,
    this.passwordToMatch,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        validator: (value) {
          if (widget.customValidator != null) {
            if (widget.passwordToMatch != null)
              return widget.customValidator(value, widget.passwordToMatch);
            else {
              return widget.customValidator(value);
            } // Call the customValidator function
          }
          return null;
        },
        focusNode: widget.focusNode,
        controller: widget.customController,
       // obscureText: isHide,
        obscuringCharacter: '*',
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.prefixicon),
          // suffixIcon: IconButton(
          //     onPressed: () {
          //       showHidePassword();
          //     },
          //     icon: !isHide
          //         ? Icon(widget.suffixicon)
          //         : Icon(Icons.visibility_off)),
          hintText: widget.hintext,
          labelText: widget.labeltexts,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.blackcolor)),
        ),
        onFieldSubmitted: (value) {
          if (widget.onFieldSubmitted != null) {
            widget.onFieldSubmitted!(value); // Call the provided callback
          }
        },
      ),
    );
  }

  // bool isHide = false;

  // showHidePassword() {
  //   isHide = !isHide;
  //   setState(() {});
  // }
}
