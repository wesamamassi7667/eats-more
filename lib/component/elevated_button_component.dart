
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';
class ElevatedButtonComponent extends StatelessWidget {
  final Function tap;
  final String title;
  final bool loading;
  const ElevatedButtonComponent({
    Key key, this.tap, this.title, this.loading=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: tap,
      child:loading?CupertinoActivityIndicator(): Text(
        title,
        style: TextStyle(
          fontFamily: 'DIN Next LT Arabic',
          fontSize: 18,
          color: background,
        ),
      ),
      style: ElevatedButton.styleFrom(
          primary: primaryIconColor,
          side: BorderSide(
            color: green,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22))),
    );
  }
}