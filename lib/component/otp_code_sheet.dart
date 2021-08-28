import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'app_text_field.dart';
import 'close_button_sheet.dart';
import 'elevated_button_component.dart';

class OTPCodeSheet extends StatefulWidget {
  final String token;
  final String otpToken;
  final double total;

  const OTPCodeSheet({Key key, this.token, this.otpToken, this.total})
      : super(key: key);

  @override
  _OTPCodeSheetState createState() => _OTPCodeSheetState();
}

class _OTPCodeSheetState extends State<OTPCodeSheet> {
  FocusNode _firstCodeFocusNode = new FocusNode();
  FocusNode _secondCodeFocusNode = new FocusNode();
  FocusNode _thirdCodeFocusNode = new FocusNode();
  FocusNode _fourthCodeFocusNode = new FocusNode();

  TextEditingController _firstCode = new TextEditingController();
  TextEditingController _secondCode = new TextEditingController();
  TextEditingController _thirdCode = new TextEditingController();
  TextEditingController _fourthCode = new TextEditingController();
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CloseButtonSheet(),
            Center(
              child: Image.asset(
                'assets/images/rajihi.jpg',
                width: 250,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 33.0),
                  child: Text(
                    'OTP :',
                    style: TextStyle(
                        fontFamily: 'DIN Next LT Arabic',
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 33),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  APPTextField(
                    hintText: '',
                    textType: TextInputType.number,
                    focusNode: _firstCodeFocusNode,
                    nextFocus: _secondCodeFocusNode,
                    textEditingController: _firstCode,
                    // isCode:true,
                    width: size.width * 0.173,
                    maxLength: 1,
                    isCenter: true,
                  ),
                  APPTextField(
                    hintText: '',
                    textType: TextInputType.number,
                    focusNode: _secondCodeFocusNode,
                    nextFocus: _thirdCodeFocusNode,
                    textEditingController: _secondCode,
                    width: size.width * 0.173,
                    maxLength: 1,
                    isCenter: true,
                  ),
                  APPTextField(
                    hintText: '',
                    textType: TextInputType.number,
                    focusNode: _thirdCodeFocusNode,
                    nextFocus: _fourthCodeFocusNode,
                    textEditingController: _thirdCode,
                    width: size.width * 0.173,
                    maxLength: 1,
                    isCenter: true,
                  ),
                  APPTextField(
                    hintText: '',
                    textType: TextInputType.number,
                    focusNode: _fourthCodeFocusNode,
                    textEditingController: _fourthCode,
                    width: size.width * 0.173,
                    maxLength: 1,
                    isCenter: true,
                    onChange: (value) {
                      _checkOtPCode();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 33),
              child: ElevatedButtonComponent(
                title: AppLocalization.of(context).translate("confirm"),
                loading: _isLoading,
                tap: () {
                  _checkOtPCode();
                },
              ),
            ),
           SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  void _checkOtPCode() async {
    setState(() {
      _isLoading = true;
    });
    var _body = {
      "OTPValue": '${_firstCode.text.trim()}${_secondCode.text
          .trim()}${_thirdCode.text.trim()}${_fourthCode.text.trim()}',
      "OTPToken": widget.otpToken,
      "amount": widget.total.toString(),
      "lang": UtilSharedPreferences.getInt('lang')==0?'en':'ar',
    };
    await ScopedModel.of<RestaurantsApiModel>(context).checkOtpCode(
        widget.token, _body).then((value) {
       if(value.data.status==200){
         Navigator.pop(context,value.data.transactionID);
       }
       else{
         AppDialog.showMe(context, value.data.message);
       }
       if(mounted)
         setState(() {
           _isLoading=false;
         });
    });
  }
}


