import 'package:flutter/material.dart';
class JumpingDot extends AnimatedWidget {
  JumpingDot({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
      height: animation.value,
      child: Text('.'),
    );
  }
}