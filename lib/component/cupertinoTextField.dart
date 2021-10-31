
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class CupertinoField extends StatelessWidget {
  final String hint;
  final Widget suffix;
  final TextEditingController controller;
  final double fontSize;
  final bool isEnabled;
  final  TextInputType inputType;
  const CupertinoField({Key key, this.hint, this.suffix, this.fontSize,
    this.controller, this.inputType=TextInputType.number, this .isEnabled=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      enabled: isEnabled,
      controller: controller,
      suffix: suffix,
      prefix: hint==AppLocalization.of(context).translate("mobile_number")?IntrinsicHeight(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 12),
              child: Text("+966"),
            ),
            VerticalDivider(
              color: black,
            ),
          ],
        ),
      ):null,
      padding: const EdgeInsetsDirectional.only(top: 12,bottom: 12,start: 12),
      clearButtonMode: isEnabled?OverlayVisibilityMode.editing:OverlayVisibilityMode.notEditing,
      textCapitalization: TextCapitalization.words,
      keyboardType:inputType ,
      autocorrect: false,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffF4F4FB)),
      style: TextStyle(fontSize: 15),
      placeholder:hint,
      placeholderStyle: TextStyle(fontSize: fontSize),

    );
  }
}
