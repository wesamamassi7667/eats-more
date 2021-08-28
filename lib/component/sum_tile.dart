
import 'package:flutter/material.dart';

import '../color.dart';
class SumTile extends StatelessWidget {
  final String title;
  final String price;
  final   Color color;
  const SumTile({
    Key key, this.title, this.price, this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'DIN Next LT Arabic',
            fontSize: 17,
            color: black5,
            fontWeight: FontWeight.w300,
          ),
        ),
        Spacer(),
        Text(
          price,
          style: TextStyle(
            fontFamily: 'DIN Next LT Arabic',
            fontSize: 15,
            color: color,
            fontWeight: FontWeight.w300,
          ),
        )
      ],
    );
  }
}
