
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/row_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstContainerDialog extends StatelessWidget {
  final Function tap;

  const FirstContainerDialog({Key key, this.tap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 26.9),
              child: SvgPicture.asset(
                'assets/images/point.svg'
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18 ),
              child: Text(
                'هل تود استبدال نقاطك بخصم 25 ريال من اجمالي الفاتورة',
                style: TextStyle(
                  fontFamily: 'DIN Next LT Arabic',
                  fontSize: 18,
                  color: black5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30,),
            RowButtons(
            tap: tap,
              width: 133,
            )
          ],

    );
  }
}
