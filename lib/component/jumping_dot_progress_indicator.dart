
import 'package:eat_more_app/animation/jumping_dot.dart';
import 'package:flutter/material.dart';
class JumpingDotsProgressIndicator extends StatefulWidget {
  final int numberOfDots;
  final double beginTweenValue = 0.0;
  final double endTweenValue = 8.0;

  JumpingDotsProgressIndicator({this.numberOfDots = 3,});

  _JumpingDotsProgressIndicatorState createState() =>
      _JumpingDotsProgressIndicatorState(
        numberOfDots: this.numberOfDots,
      );
}

class _JumpingDotsProgressIndicatorState
    extends State<JumpingDotsProgressIndicator> with TickerProviderStateMixin {
  int numberOfDots;
  List<AnimationController> controllers = [];
  List<Animation<double>> animations = [];
  List<Widget> _widgets = [];

  initState() {
    super.initState();
    for (int i = 0; i < numberOfDots; i++) {
// adding controllers
      controllers.add(AnimationController(
          duration: Duration(milliseconds: 250), vsync: this));
// adding animation values
      animations.add(
          Tween(begin: widget.beginTweenValue, end: widget.endTweenValue)
              .animate(controllers[i])
            ..addStatusListener((AnimationStatus status) {
              if (status == AnimationStatus.completed)
                controllers[i].reverse();
              if (i == numberOfDots - 1 &&
                  status == AnimationStatus.dismissed) {
                controllers[0].forward();
              }
              if (animations[i].value > widget.endTweenValue / 2 &&
                  i< numberOfDots - 1) {
                controllers[i + 1].forward();
              }
            }));
// adding list of widgets
      _widgets.add(Padding(
        padding: EdgeInsets.only(right: 1.0),
        child: JumpingDot(
          animation: animations[i],
        ),
      ));
    }
// animating first dot in the list
    controllers[0].forward();
  }
  @override
  dispose() {
    for (int i = 0; i < numberOfDots; i++){controllers[i].dispose();}
    super.dispose();
  }
  _JumpingDotsProgressIndicatorState({this.numberOfDots,});
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _widgets,
      ),
    );
  }
}