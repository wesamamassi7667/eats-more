import 'package:flutter/material.dart';

import '../color.dart';
class ContainerComponent extends StatelessWidget {
  final Widget child;


  const ContainerComponent({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(44.0),
          topRight: Radius.circular(44.0),),
        color: background,
        // boxShadow: [
        //   BoxShadow(
        //     color: black.withOpacity(0.1),
        //     offset: Offset(8, -16),
        //   ),
        // ],
      ),
      child: child,
    );
  }
}

class SecondContainerComponent extends StatelessWidget {
  final Widget child;

  const SecondContainerComponent({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: background,
        boxShadow: [
          BoxShadow(
            color: grey5.withOpacity(0.16),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: child,
    );
  }
}