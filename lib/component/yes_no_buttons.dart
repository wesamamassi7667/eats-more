import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';
class YesNoButtons extends StatelessWidget {
  final Function tap;
  final bool isLoading;
  final double width;
  final Function pressNo;

  const YesNoButtons({Key key, this.tap, this.isLoading=false, this.width, this.pressNo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: width,
          child: TextButton(
            onPressed: tap,
            child: isLoading?CupertinoActivityIndicator():Text(
              AppLocalization.of(context).translate("yes"),),
            style: AppThemeData.textButtonStyle(borderRadius: 16,fontSize: 17)
          ),
        ),
        Container(
          width: width,
          child: OutlinedButton(
            onPressed: pressNo,
            child: Text(
              AppLocalization.of(context).translate("no")
            ),
              style: AppThemeData.buttonStyle(borderRadius: 16,fontSize: 17)

          )
        )
      ],
    );
  }
}
