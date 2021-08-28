
import 'package:eat_more_app/color.dart';
import 'package:flutter/material.dart';
class UnActiveDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width:7,
      height: 7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
        color: const Color(0x85707070),
        border: Border.all(width: 1.0, color: const Color(0x85eeeeee)),
      ),
    );
  }
}
class ActiveDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(0xff0068b0),
      ),
    );
  }
}
class UnActiveDotHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width:7,
      height: 7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
        border: Border.all(width: 1.0, color: primaryIconColor.withOpacity(0.84)),
      ),
    );
  }
}



