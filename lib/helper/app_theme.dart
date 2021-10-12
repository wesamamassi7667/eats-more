


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

  static OutlineInputBorder borderTextField(Color color, double borderRadius,
      double widthBorder) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
          style: BorderStyle.solid,
          width: widthBorder,
          color: color
      ),
    );
  }

  static ButtonStyle textButtonStyle({double borderRadius=20.0,double fontSize=14.0,Color backgroundColor=primaryIconColor,
    Color primary=background}){
    return TextButton.styleFrom(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius))
      ),
      primary: primary, // This is a text color
      backgroundColor:backgroundColor ,
      textStyle: TextStyle(fontWeight:FontWeight.w400,fontSize:fontSize),
    );
  }

  static ButtonStyle buttonStyle({double borderRadius=20.0,double fontSize=14.0}){
    return OutlinedButton.styleFrom(
      textStyle: TextStyle(fontWeight:FontWeight.w400,fontSize:fontSize,fontFamily:'DIN Next LT Arabic'),
      primary: primaryIconColor,
      side: BorderSide(
          width: 1.0,
          color: primaryIconColor,
          style: BorderStyle.solid,
      ),
      padding: EdgeInsets.all(0),
     shape: RoundedRectangleBorder(
          borderRadius:  BorderRadius.all(Radius.circular(borderRadius))
      ),
    );
  }
  static ButtonStyle elevatedButtonStyle(){
    return ElevatedButton.styleFrom(
      textStyle: TextStyle(
        fontFamily: 'DIN Next LT Arabic',
        fontSize: 18,
        color: background,
      ),
        primary: primaryIconColor,
        side: BorderSide(
          color: green,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22))
    );
  }
}

