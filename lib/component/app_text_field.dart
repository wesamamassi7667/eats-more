import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/helper/app_theme.dart';
import 'package:flutter/material.dart';
class APPTextField extends StatelessWidget {
  final String hintText;
  final TextInputType textType;
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final FocusNode nextFocus;
  final String errMessage;
  final Widget prifexIcon;
  final Widget suffixIcon;
  final bool isEnabled;
  final double width;
  final bool isMultiLine;
  final TextAlign align;
  final int maxLength;
  final bool isCenter;
  final Function(String) onChange;


  const APPTextField({Key key, this.hintText, this.textType, this.focusNode, this.textEditingController, this.nextFocus, this.errMessage,
    this.prifexIcon, this.suffixIcon, this.isEnabled, this.width=double.infinity, this.isMultiLine=false,this.align=TextAlign.start, this.maxLength, this.isCenter=false, this.onChange}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextFormField(
        maxLines:isMultiLine?15: 1,
        enabled: isEnabled,
        onChanged: (value){
          if(value.length==1&&maxLength==1){
            focusNode.unfocus();
            if(nextFocus!=null)
              FocusScope.of(context).requestFocus(nextFocus);}
          if(onChange!=null)
          onChange(value);

        },
        maxLength: maxLength,

        minLines: isMultiLine?10:1,
        enableInteractiveSelection:true,
        focusNode: focusNode,
        controller: textEditingController,
        textAlign:isCenter?TextAlign.center: align,
        validator:(value){
          if (value.trim() == "") {
            focusNode?.unfocus();
            return errMessage;
          }
          return null;
        },
        onFieldSubmitted: (s){
          focusNode?.unfocus();
          if(nextFocus!=null)
            FocusScope.of(context).requestFocus(nextFocus);

        },
        textInputAction:isMultiLine?TextInputAction.newline: nextFocus!=null?TextInputAction.next:TextInputAction.done,
        keyboardType: textType,
        decoration: AppThemeData.inputDecoration(hintText,prifexIcon,suffixIcon,context),
        style: TextStyle(
          fontFamily: 'DIN Next LT W23',
          fontSize: 15,
          color: primaryIconColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}