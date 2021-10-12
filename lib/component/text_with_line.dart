

import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../color.dart';
class TextWithLine extends StatelessWidget {
  final bool isOffer;
  final String price;
  final double fontSize;
  final double bottom;
  const TextWithLine({
    Key key, this.isOffer, this.price, this.fontSize=16,this.bottom=13
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<RestaurantsApiModel>(
      builder: (context,child,model)=>Container(
        //15
        // height: isOffer?24:24,
        child: Stack(
          children: [
            Text(
              price+" "+AppLocalization.of(context).translate("sr"),
              style: TextStyle(
                fontSize: fontSize,
                color: orange,
              ),
            ),
            !isOffer?  SizedBox.shrink():Positioned(
              bottom: model.language==1?13:9,
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
      ),
    );
  }
}
