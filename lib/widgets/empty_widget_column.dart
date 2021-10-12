import 'package:eat_more_app/helper/app_localization.dart';
import 'package:flutter/material.dart';

import '../color.dart';
class EmptyWidgetColumn extends StatelessWidget {
  const EmptyWidgetColumn({Key key, this.message, this.icon}) : super(key: key);
   final String message;
   final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Icon(
            icon,
            size: 100,
            color: grey1,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(AppLocalization.of(context).translate(message)),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
