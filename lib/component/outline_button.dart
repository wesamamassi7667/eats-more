import 'package:eat_more_app/helper/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';

class OutLineButton extends StatelessWidget {
  final Function tap;
  final String  text;
  final double width;
  final bool loading;

  const OutLineButton({Key key, this.tap, this.width, this.text, this.loading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: width,
      child: OutlinedButton(
        onPressed: tap,
        child:loading?CupertinoActivityIndicator(): Text(
          text,
          style: TextStyle(
            fontFamily: 'DIN Next LT Arabic',
            fontSize: 18,
            color: primaryIconColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        // style:  AppThemeData.buttonStyle(widthBorder: 1.0,borderColor:primaryIconColor)
        // OutlinedButton.styleFrom(
        //   side: BorderSide(
        //     width: 1.0,
        //     color: const Color(0xff0068b0),
        //     style: BorderStyle.solid,
        //   ),
        //   shape:RoundedRectangleBorder(
        //       borderRadius: const BorderRadius.all(Radius.circular(20))
        //   ),

        ),

    );
  }
}

