import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../color.dart';
import '../app_dialog.dart';
import '../my_progress_indicator.dart';

class Common {
  // showBottomSheet: the sheet take full height and can sliding it
  static BorderRadius borderRadiusRightLeft = BorderRadius.only(
    topRight: Radius.circular(25),
    topLeft: Radius.circular(25),
  );

  static showSlideUpLoginView(BuildContext context) {
    showBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius:borderRadiusRightLeft
        ),
        builder: (context) {
          return ClipRRect(
            borderRadius: borderRadiusRightLeft,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                child: LoginScreen(isSheet: true)),
          );
        }
        );
  }

  static Future<dynamic> showModalBottom(BuildContext context, Widget widget,
      {bool isDrag = true,bool isScrollControlled=true}) {
    return showModalBottomSheet(
        context: context,
        enableDrag: isDrag,
        isDismissible: false,
        isScrollControlled: isScrollControlled,
        shape: RoundedRectangleBorder(
            borderRadius: borderRadiusRightLeft,
            side: BorderSide(width: 1, color: grey4)),
        builder: (context) => widget
    );
  }


  static showSingleAnimationDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
        child: MyProgressIndicator(),
      ),
    );
  }

  static void showError(err,context) {
    Navigator.pop(context);
    AppDialog.showMe(context, err.toString());
  }

  static void showAlertDialog(BuildContext context, String title, String title1, Function tap) {
    showDialog(
        context: context,
        builder: (context) =>
            CupertinoAlertDialog(
              // title: Text("Log out?"),
              content: Text(title),
              actions: <Widget>[
                CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalization.of(context).translate("cancel"))
                ),
                CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: tap,
                    child: Text(title1)
                ),
              ],
            )
    );
  }

}
