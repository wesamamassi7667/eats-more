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
    Restaurant vendor=list[index];
    return ScaleAnimation(
      tap: (v)=> Navigator.pushNamed(context, '/deliveryMethod',arguments:vendor.vendor_id),
      child: SecondContainerComponent(
        height: 122,
        width: list.length==2?MediaQuery.of(context).size.width*0.4:90,
        topP: 16, bottomP: 17,
        start: index == 0 ? 23 : 8,
        end: index == list.length-1 ? 14 : 0,
        bottom: 23, top: 11,
        colorShadow: grey1,
        radius: BorderRadius.circular(10),
        child: Column(
          children: [
            VendorLogo(
              width: 58.0,
              height: 58.0,
              url: vendor.vendor_image,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              vendor.vendor_name,
              style: TextStyle(
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