import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_more_app/animation/scale_animation.dart';
import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/component/vendor_logo.dart';
import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:eat_more_app/model/home_response.dart';
import 'package:eat_more_app/screens/delivery_ways_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';
class VendorWidget extends StatelessWidget {
  const VendorWidget({
    Key key,
    @required this.list, this.index,
  }) : super(key: key);

  final List<Restaurant> list;
  final int index;
  @override
  Widget build(BuildContext context) {
    return ScaleAnimation(
      tap: (v)=> Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveryMethodsScreen(
            id:list[index].vendor_id
        )
        )
        ),
      child: SecondContainerComponent(
        height: 122,
        width: list.length==2?MediaQuery.of(context).size.width*0.4:90,
        topP: 16,
        bottomP: 17,
        start: index == 0 ? 23 : 8,
        end: index == list.length-1 ? 14 : 0,
        bottom: 23, top: 11,
        colorShadow: grey1,
        child: Column(
          children: [
            VendorLogo(
              width: 58.0,
              height: 58.0,
              url: list[index].vendor_image,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              list[index].vendor_name,
              style: TextStyle(
                fontFamily: 'DIN Next LT Arabic',
                fontSize: 16,
                color: black2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}