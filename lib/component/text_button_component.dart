
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/helper/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TextButtonComponent extends StatelessWidget {
  final Function press;
  final String text;
  final Color primary,backgroundColor,borderColor;
  final double widthBorder;
  final bool loading;
  final double fontSize;
  final double  width;


  const TextButtonComponent({
    Key key, this.press, this.text, this.primary=primaryIconColor, this.backgroundColor=Colors.transparent,
    this.borderColor=Colors.transparent, this.widthBorder=0.0, this.loading=false, this.fontSize=14.0,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
       width: width,
      child: TextButton(
          onPressed:press,
          child: loading?CupertinoActivityIndicator():Text(text,
            style: TextStyle(fontWeight:FontWeight.w400,fontSize:fontSize,fontFamily:'DIN Next LT Arabic'),
          ),
          // style: AppThemeData.buttonStyle(
          //     background: backgroundColor,
          //     primary: primary,
          //     widthBorder: widthBorder,
          //     borderColor: borderColor
          // ),
      ),
    );
  }
}
