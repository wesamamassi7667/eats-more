import 'package:eat_more_app/color.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
class   MyProgressIndicator extends StatelessWidget {

  const MyProgressIndicator({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 20,
        width: 40,
        child: LoadingIndicator(
            indicatorType: Indicator.ballPulse, /// Required, The loading type of the widget
            colors: const [black],       /// Optional, The color collections
            backgroundColor: Colors.transparent,      /// Optional, Background of the widget
        ),
      ),
    );
  }
}
