

import 'package:eat_more_app/helper/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../color.dart';

class ContactComponent extends StatelessWidget {
final int index;

  const ContactComponent({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 104,
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(0, 7),
              color: grey13.withOpacity(0.16),
            ),
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          index==0? SvgPicture.asset('assets/images/whatsapp.svg'):
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: primaryIconColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              index==1?Icons.email:Icons.phone_android,
              color: background,
            ),
          ),
          SizedBox(height: 4,),
          Text(
            index==0?AppLocalization.of(context).translate("chat"):index==1?AppLocalization.of(context).translate("email"):
            AppLocalization.of(context).translate("call"),
            style: TextStyle(
              fontFamily: 'DIN Next LT Arabic',
              fontSize: 17,
              color: black1,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
