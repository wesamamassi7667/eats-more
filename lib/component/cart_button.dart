import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../color.dart';

class CartButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function tap;
  final bool isLoading;
  final double total;
  final Color textColor;

  const CartButton(
      {Key key,
      this.color,
      this.text,
      this.tap,
      this.isLoading = false,
      this.total,
      this.textColor = background})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: CupertinoActivityIndicator())
        : ScopedModelDescendant<RestaurantsApiModel>(
            builder: (context, child, model) => Directionality(
              textDirection: TextDirection.ltr,
              child: TextButton.icon(
                onPressed: tap,
                label: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'DIN Next LT Arabic',
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Stack(
                    alignment: AlignmentDirectional(
                        -1.5, model.language == 0 ? -3.9 : -11),
                    children: [
                      Icon(
                        CupertinoIcons.shopping_cart,
                        color: Colors.white,
                        size: model.language == 0 ? 25 : 27,
                      ),
                      Directionality(
                        textDirection: model.language == 0
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        child: RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(children: [
                            TextSpan(
                                text: total == null ? "0.0 " : '$total ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: orange)),
                            TextSpan(
                                text:
                                    AppLocalization.of(context).translate("sr"),
                                style: TextStyle(
                                  color: white2,
                                  fontWeight: FontWeight.w600,
                                ))
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
          );
  }
}
