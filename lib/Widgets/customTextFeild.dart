import 'package:flutter/material.dart';
import 'package:fiverrproject1/utilities/constants.dart';

/*
* A widget housing bordered input box with text holder that moves on tap. The
* widget allows the customization of its text colour, placeholder colour and
* active border colour.
*
* */
class CustomTextField extends StatelessWidget {
  final String placeholder;
  final Color cursorColor;
  final Color placeholderColor;
  final Color focusedOutlineBorder;
  final bool isPassword;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final TextEditingController controller;

  final int minLines;
  final int maxLines;

  CustomTextField({
    @required this.placeholder,
    this.cursorColor = kRedColor,
    this.placeholderColor = kRedColor,
    this.focusedOutlineBorder = kRedColor,
    this.onChanged,
    this.isPassword = false,
    this.keyboardType,
    this.minLines = 1,
    this.maxLines = 1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: this.minLines,
      maxLines: this.maxLines,
      obscureText: this.isPassword,
      cursorColor: this.cursorColor,
      decoration: InputDecoration(
        labelText: this.placeholder,
        hasFloatingPlaceholder: true,
        labelStyle: TextStyle(
          color: this.placeholderColor,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: this.focusedOutlineBorder,
          ),
        ),
      ),
      onChanged: this.onChanged,
      controller: this.controller,
    );
  }
}
