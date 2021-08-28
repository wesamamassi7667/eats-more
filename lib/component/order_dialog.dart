
import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/component/elevated_button_component.dart';
import 'package:eat_more_app/component/first_container_dialog.dart';
import 'package:eat_more_app/component/second_container_dialog.dart';
import 'package:eat_more_app/model/order_response.dart';
import 'package:flutter/material.dart';

import '../color.dart';
class OrderDialog extends StatefulWidget {
  final int orderId;

  const OrderDialog({Key key, this.orderId}) : super(key: key);

  @override
  _OrderDialogState createState() => _OrderDialogState();
}

class _OrderDialogState extends State<OrderDialog> {
  var _showSecond = false;

  @override
  Widget build(BuildContext context) {
    return  Dialog(
          backgroundColor: background,

          child: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            height:_showSecond?320:410,
            child: _showSecond?SecondContainerDialog(
              orderId :widget.orderId,
            ):FirstContainerDialog(
              tap: (){
                setState(() {
                  _showSecond=true;
                });
              },
            ),

          ),
    );
  }
}





class DateOrder extends StatelessWidget {
  final String text1;
  final String text2;
  const DateOrder({
    Key key, this.text1, this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 60,end: 60),
      child: Row(
        children: [
          Text(
            text1,
            style: TextStyle(
              fontFamily: 'DIN Next LT Arabic',
              fontSize: 16,
              color: black5,
            ),
          ),
          Spacer(),
          Text(
            text2,
            style: TextStyle(
              fontFamily: 'DIN Next LT Arabic',
              fontSize: 14,
              color: grey4,
              fontWeight: FontWeight.w500,
            ),
          ),


        ],
      ),
    );
  }
}
