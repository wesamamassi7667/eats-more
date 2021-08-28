import 'package:eat_more_app/helper/app_localization.dart';
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
              AppLocalization.of(context).translate("yes"),
              style: TextStyle(
                fontFamily: 'DIN Next LT Arabic',
                fontSize: 17,
                color: background,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: primaryIconColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16))),
          ),
        ),
        Container(
          width: width,
          child: TextButton(
            onPressed: pressNo,
            child: Text(
              AppLocalization.of(context).translate("no"),
              style: TextStyle(
                fontFamily: 'DIN Next LT Arabic',
                fontSize: 17,
                color: primaryIconColor,
              ),
            ),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: primaryIconColor, width: 1),
                    borderRadius: BorderRadius.circular(16))),
          ),
        )
      ],
    );
  }
}
