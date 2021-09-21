
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/helper/app_theme.dart';
import 'package:flutter/material.dart';


class TextButtonComponent extends StatelessWidget {
  final Function press;
  final String text;
  final Color primary,backgroundColor,borderColor;
  final double widthBorder;


  const TextButtonComponent({
    Key key, this.press, this.text, this.primary=primaryIconColor, this.backgroundColor=Colors.transparent,
    this.borderColor=Colors.transparent, this.widthBorder=0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
       width: MediaQuery.of(context).size.width*0.4,
      child: TextButton(
          onPressed:press,
          child: Text(text,
            style: TextStyle(fontWeight:FontWeight.w400,fontSize:14,fontFamily:'DIN Next LT Arabic'),
          ),
          style: AppThemeData.buttonStyle(
              background: backgroundColor,
              primary: primary,
              widthBorder: widthBorder,
              borderColor: borderColor
          ),
      ),
    );
  }
}
