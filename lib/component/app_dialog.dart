

import 'package:eat_more_app/helper/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AppDialog {
  final String message;

  AppDialog(this.message);

  static void showMe(BuildContext context, String message,
      {bool isError = true,Function onClickOk}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title:isError? Text(
          'Error',
          style: TextStyle(
              fontWeight:FontWeight.w800, fontSize:17,
              color:Colors.black,
              fontFamily:'DIN Next LT Arabic'
          ),
          textAlign: TextAlign.center,
        ):SizedBox.shrink(),

        content: Text(
          message,
          style: TextStyle(fontWeight:FontWeight.w400,fontSize:15,color:Colors.black,fontFamily:'DIN Next LT Arabic'),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(
              AppLocalization.of(context).translate('ok'),
              style: TextStyle(
                  fontWeight:FontWeight.w300,
                  fontSize:14,
                  color:isError ? Colors.red : Colors.blueAccent,
                  fontFamily:'DIN Next LT Arabic'
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              if (onClickOk != null)
                onClickOk();
            },
          ),
        ],
      ),
    );
  }
}