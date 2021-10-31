import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';

class RowButtons extends StatelessWidget {
  final Function tap;
  final bool isLoading;
  final double width;
  final Function pressFirst;
  final Function pressSecond;

  final String text1;
  final String text2;

  const RowButtons(
      {Key key,
      this.tap,
      this.isLoading = false,
      this.width,
      this.pressSecond,
      this.pressFirst,
      this.text1,
      this.text2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: width,
          child: TextButton(
              onPressed: pressFirst,
              child: isLoading ? CupertinoActivityIndicator() : Text(text1),
              style:
                  AppThemeData.textButtonStyle(borderRadius: 16, fontSize: 17)),
        ),
        Container(
            width: width,
            child: OutlinedButton(
                onPressed: pressSecond,
                child: Text(text2),
                style:
                    AppThemeData.buttonStyle(borderRadius: 16, fontSize: 17)))
      ],
    );
  }
}
