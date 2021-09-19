import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';
class ContainerComponent extends StatelessWidget {
  final Widget child;


  const ContainerComponent({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(44.0),
          topRight: Radius.circular(44.0),),
        color: background,
        // boxShadow: [
        //   BoxShadow(
        //     color: black.withOpacity(0.1),
        //     offset: Offset(8, -16),
        //   ),
        // ],
      ),
      child: child,
    );
  }
}

class SecondContainerComponent extends StatelessWidget {
  final Widget child;
  final double width,height;
  final double start,end,top,bottom;
  final double startP,endP,topP,bottomP;
  final BorderRadius radius;
  final Color colorShadow;
  final ImageProvider image;
  final Border border;


  const SecondContainerComponent({Key key, this.child, this.width, this.height, this.start=16.0, this.end=16.0,
    this.radius, this.colorShadow=grey5, this.image, this.top=0.0, this.bottom=0.0,
    this.startP=0.0, this.endP=0.0, this.topP=0.0, this.bottomP=0.0, this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin:EdgeInsetsDirectional.only(start:start,end: end,top:top,bottom:bottom) ,
      padding: EdgeInsetsDirectional.only(start:startP,end: endP,top:topP,bottom:bottomP),
      decoration: BoxDecoration(
        borderRadius: radius,
        color: background,
        image: image==null?null:DecorationImage(
          image: image,
        ),
        border: border,
        boxShadow: [
          BoxShadow(
            color: colorShadow.withOpacity(0.16),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: child,
    );
  }
}