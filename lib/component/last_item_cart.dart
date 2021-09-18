
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/model/order_response.dart';
import 'package:flutter/material.dart';

import '../color.dart';
class LastRowCart extends StatelessWidget {
  const LastRowCart({
    Key key, this.total, this.minimum, this.order,
  }) : super(key: key);
  final double total;
  final double minimum;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Text(
                AppLocalization.of(context).translate("total") ,
                style: TextStyle(
                  fontFamily:
                  'DIN Next LT Arabic',
                  fontSize: 19,
                  color: black1,
                ),
              ),
              SizedBox(
                width: 34,
              ),
              Text(
                '$total' + " "+ AppLocalization.of(context).translate("sr") ,
                style: TextStyle(
                    fontFamily:
                    'DIN Next LT Arabic',
                    fontSize: 16,
                    color:
                    green.withOpacity(
                        0.93)),
              )
            ],
          ),
         order==null?total<minimum? Padding(
           padding: const EdgeInsets.only(top:8.0),
           child: Text(
                AppLocalization.of(context).translate("minimum_charge_for_order")+" "+
                    '$minimum'+
                    AppLocalization.of(context).translate("sr"),
              style: TextStyle(
                color: red,
                fontFamily: 'DIN Next LT Arabic'
              ),
            ),
         ):SizedBox.shrink():SizedBox.shrink()
        ],
      ),
    );
  }
}