
import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/helper/helper.dart';
import 'package:flutter/material.dart';

import '../color.dart';
class VendorLogo extends StatelessWidget {
  final String url;
  final width,height;
  final Border border;


  const VendorLogo({Key key, this.url, this.width=49.0, this.height=49.0, this.border}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  SecondContainerComponent(
      width:width ,
      height:height,
      border: border,
      radius: BorderRadius.all(
          Radius.elliptical(9999.0, 9999.0)),
      colorShadow: black,
      image: Helper.buildCachedNetworkImageProvider(url),
    );
  }
}
