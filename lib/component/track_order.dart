import 'package:eat_more_app/model/order_response.dart';
import 'package:flutter/material.dart';

import '../color.dart';
import 'my_stepper.dart';

class TrackWidget extends StatelessWidget {
  const TrackWidget({
    Key key,
    @required TrackOrder orderStatus,
    @required List<Object> icons,
    @required  status,
  }) : _orderStatus = orderStatus, _icons = icons, _status = status, super(key: key);

  final TrackOrder _orderStatus;
  final List<Object> _icons;
  final List<String> _status;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${_orderStatus.order.order_number}',
            ),
            Spacer(),
            Row(
              children: [
                Image.asset('assets/images/marker.png',width: 30,height: 30,),
                SizedBox(width: 2,),
                Text(
                  '${_orderStatus.branch.branch.branch_name}',
                  style: TextStyle(
                      fontFamily: 'DIN Next LT Arabic'
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20,),
        Expanded(
          child: MyStepper(
              statusOrder:_orderStatus.status,
              icons: _icons,
              activeColor: primaryIconColor,
              inactiveColor: background,
              status:_status,
              activeColorLine: primaryIconColor,
              inactiveColorLine: Color(0xffECECEC),
              curStep: _orderStatus.status[_orderStatus.status.length-1].status_desc,
              inactiveBorderColor: Color(0xffD8D8D8)),
        ),

      ],
    );
  }
}
