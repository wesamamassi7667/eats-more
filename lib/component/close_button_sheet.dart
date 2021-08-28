
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';
class CloseButtonSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top:15,end: 15),
      child: CupertinoButton(
        onPressed: (){
          Navigator.pop(context);
        },
        child: Icon(
          Icons.cancel_outlined,
          color: grey4
              .withOpacity(0.79),
        ),
      ),
    );
  }
}
