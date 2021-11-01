import 'package:eat_more_app/component/image_card.dart';
import 'package:eat_more_app/helper/helper.dart';
import 'package:eat_more_app/model/order_response.dart';
import 'package:flutter/material.dart';

import '../color.dart';
import 'container_component.dart';

class HeaderOrderDetails extends StatelessWidget {
  const HeaderOrderDetails({
    Key key, this.order,
  }) : super(key: key);
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsetsDirectional.only(start: 28),
      child: Row(
        children: [
          SecondContainerComponent(
            radius:BorderRadius.circular(8.0),
            width: 69,height: 69,
            image:AssetImage('assets/images/logo.jpg'),
            border: Border.all(
                width: 1.0,
                color: white2),
            colorShadow: black,
          ),
          SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '#' + '${order.order_number}',
                style: TextStyle(
                  fontSize: 18,
                  color: black2.withOpacity(0.76),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                order.order_date,
                style: TextStyle(
                  fontSize: 13,
                  color: grey4.withOpacity(0.78),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                order.order_status.name,
                style: TextStyle(
                  fontSize: 14,
                  color: orange,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Spacer(), //النقاط
        ],
      ),
    );
  }
}
