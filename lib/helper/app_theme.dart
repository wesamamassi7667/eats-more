


import 'package:eat_more_app/color.dart';
import 'package:flutter/material.dart';
class AppThemeData {
  static TextStyle hintText =
  TextStyle(
    fontFamily: 'DIN Next LT W23',
    fontSize: 13,
    color: black1,
    fontWeight: FontWeight.w400,
  );

  static InputDecoration inputDecoration(String hint, Widget PrefixIcon,
      Widget suffixIcon,BuildContext context) {
    return InputDecoration(
      contentPadding: const EdgeInsetsDirectional.only(
          start: 27, top: 10, bottom: 11, end: 25),
      labelText: hint,
      // hintText: hint,
      alignLabelWithHint: true,
      labelStyle: hintText,
      suffixIcon: suffixIcon,
      prefixIcon: PrefixIcon,
      isDense: false,
      errorStyle: TextStyle(
        color: Theme.of(context).errorColor, // or any other color
      ),
      enabledBorder: borderTextField(primaryIconColor, 5, 1),
      focusedBorder: borderTextField(primaryIconColor,5, 1),
      errorBorder: borderTextField(Colors.red, 5, 1),
      focusedErrorBorder:borderTextField(Colors.red, 5, 1) ,
      disabledBorder: borderTextField(grey11, 5, 1),
      border: borderTextField(grey11, 5, 1),
    );
  }

  static OutlineInputBorder borderTextField(Color color, double borderRaduis,
      double widthBorder) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRaduis),
      borderSide: BorderSide(
          style: BorderStyle.solid,
          width: widthBorder,
          color: color
      ),
    );
  }

}

