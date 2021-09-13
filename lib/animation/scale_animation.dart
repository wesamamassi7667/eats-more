
import 'package:flutter/material.dart';

class ScaleAnimation extends StatefulWidget {
  final Widget child;
  final Function tap;

   ScaleAnimation({Key key, this.child, this.tap}) : super(key: key);

  @override
  _ScaleAnimationState createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    AnimationController ctrl = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    Animation scaleAnimation =
    Tween(begin: 1.0, end: 0.7).animate(ctrl);
    selectItem(bool forward) =>
        forward ? ctrl.forward() : ctrl.reverse();
    return ScaleTransition(
      scale: scaleAnimation,
      child: GestureDetector(
        onTapUp: (d)=>selectItem(false),
        onTapDown: (d) => selectItem(true),
        onTapCancel: () => selectItem(false),
        onTap: () =>
            selectItem(true).then((value) => selectItem(false).then(
                  widget.tap,
            )
            ),
        child: widget.child,
      ),
    );
  }
}

