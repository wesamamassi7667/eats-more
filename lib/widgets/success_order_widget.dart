import 'package:eat_more_app/helper/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class OrderSuccessWidget extends StatelessWidget {
  const OrderSuccessWidget({Key key, this.orderNumber}) : super(key: key);
  final String orderNumber;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: SvgPicture.asset('assets/images/cart.svg')),
        Align(
          alignment: Alignment.topCenter,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Lottie.asset(
                'assets/json/success.json',
                height: 250,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  AppLocalization.of(context).translate('congratulations'),
                  style: TextStyle(
                    fontSize: 26,
                    color: const Color(0xff026fef),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        ),
        PositionedDirectional(
          bottom: 40,
          start: 0,
          end: 0,
          child: Column(
            children: [
              Text(
                AppLocalization.of(context)
                    .translate('your_order_has_sent_successfully'),
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                AppLocalization.of(context).translate('order_number'),
                style: TextStyle(
                  fontSize: 15,
                  color: const Color(0xff026fef),
                ),
              ),
              Text(
                '$orderNumber',
                style: TextStyle(
                  fontSize: 26,
                  letterSpacing: 7.0200000000000005,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
