
import 'package:eat_more_app/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class ColumnComponent extends StatelessWidget {
  final String title;
  final String title1;
  final String icon;

  const ColumnComponent({
    Key key,
    this.title,
    this.title1,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'DIN Next LT Arabic',
            fontSize: 13,
            color: background,
          ),
        ),
        Row(
          children: [
            SvgPicture.asset(icon,color: background,),
            SizedBox(
              width: 2,
            ),
            Text(
              title1,
              style: TextStyle(
                fontFamily: 'DIN Next LT Arabic',
                fontSize: 13,
                color: background,
              ),
            ),
          ],
        )
      ],
    );
  }
}
