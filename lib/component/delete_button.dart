import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';
class DeleteButton extends StatelessWidget {
  const DeleteButton({Key key, this.press}) : super(key: key);
 final Function press;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed:press,
      child: Icon(
        Icons.cancel_outlined,
        color: grey4.withOpacity(0.79),
      ),
    );
  }
}
