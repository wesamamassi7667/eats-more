import 'package:flutter/material.dart';

import '../color.dart';

class CounterDown extends AnimatedWidget {
  CounterDown({Key key, this.animation}) : super(key: key, listenable: animation);
 final  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    return Text(
      "$timerText",
      style: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 14,
        color: orange.withOpacity(0.68),
        fontWeight: FontWeight.w300,

      ),
    );
  }
}