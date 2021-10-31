

import 'package:eat_more_app/helper/app_localization.dart';
import 'package:flutter/material.dart';

import '../color.dart';

class MobileTextField extends StatelessWidget {
  const MobileTextField({Key key, this.controller, this.color=primaryIconColor,}) : super(key: key);

  final TextEditingController controller;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 40, right: 40),
        decoration: BoxDecoration(
          color: color.withOpacity(0.4),
          borderRadius: BorderRadius.circular(9),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text("+966",
                  style: TextStyle(
                      fontFamily: 'DIN Next LT Arabic',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: black)),
              Icon(
                Icons.arrow_drop_down_rounded,
                color: black,
                // size: 15,
              ),
              VerticalDivider(
                color: black,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: TextField(
                    controller: controller,
                    style: TextStyle(color: black),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: AppLocalization.of(context)
                          .translate('mobile_number'),
                      hintStyle: TextStyle(color: Colors.black, fontSize: 13),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );

  }
}
