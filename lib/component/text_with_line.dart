

import 'package:eat_more_app/helper/app_localization.dart';
import 'package:flutter/material.dart';

import '../color.dart';
class TextWithLine extends StatelessWidget {
  final bool isOffer;
  final String price;
  final double fontSize;
  final double bottom;
  const TextWithLine({
    Key key, this.isOffer=false, this.price, this.fontSize=16,this.bottom=12
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isOffer?24:15,
      child: Stack(
        children: [
          Text(
            price+" "+AppLocalization.of(context).translate("sr"),
            style: TextStyle(
              fontFamily: 'DIN Next LT Arabic',
              fontSize: fontSize,
              color: orange,
            ),
          ),
          !isOffer?  SizedBox.shrink():Positioned(
            bottom: bottom,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsetsDirectional.only(end: 20 / 4),
              height: 3,
              color: primaryIconColor.withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}
