import 'dart:convert';

import 'package:eat_more_app/api/app_api.dart';
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/counter.dart';
import 'package:eat_more_app/component/dialog.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/app_theme.dart';
import 'package:eat_more_app/helper/helper.dart';
import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:eat_more_app/model/login_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../color.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String phone;
  final String memberCase;

  const VerificationCodeScreen({Key key, this.phone, this.memberCase})
      : super(key: key);

  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen>
    with TickerProviderStateMixin {
  TextEditingController _code = new TextEditingController();
  FocusNode _codeFocusNode;
  AnimationController _controller;
  int levelClock = 120;
  String signCode;
  var _isIgonre = false;
  var _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SmsAutoFill().unregisterListener();
    _code.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds:
                levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
        );

    super.initState();
    _listOPT();
  }

  _listOPT() async {
    await SmsAutoFill().listenForCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(
              start: 12,
              end: 12,
              bottom: 17,
              top: 132,
            ),
            padding: EdgeInsetsDirectional.only(start: 16),
            decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.12),
                      offset: Offset(3, 4))
                ]),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 69.2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/login.svg'),
                ],
              ),
              Flexible(
                child: Text(
                  AppLocalization.of(context)
                      .translate("enter_verification_code"),
                  style: TextStyle(
                    fontFamily: 'DIN Next LT Arabic',
                    fontSize: 17,
                    color: black4,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  // textAlign: TextAlign.center,
                ),
              ),
              Text(
                '(+966) ' + widget.phone.substring(3, widget.phone.length),
                style: TextStyle(
                  fontFamily: 'Cairo',
                  //cario
                  fontSize: 20,
                  color: const Color(0xff22551d),
                ),
              ),
              SizedBox(
                height: 37,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: PinFieldAutoFill(
                    codeLength: 4,
                    controller: _code,
                    currentCode: _code.text,
                    decoration: UnderlineDecoration(
                      textStyle: TextStyle(fontSize: 20, color: Colors.black),
                      colorBuilder: FixedColorBuilder(green1.withOpacity(0.07)),
                    ),
                    focusNode: _codeFocusNode,
                    onCodeSubmitted: (code) {
                      if (_codeFocusNode != null) {
                        _codeFocusNode.unfocus();
                      }
                    },
                    onCodeChanged: (code) {
                      if (code.length == 4) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        _submitCode();
                      }
                    },
                  )),
              SizedBox(
                height: 28,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 52),
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      _submitCode();
                    },
                    style: AppThemeData.buttonStyle(fontSize: 18),
                    child: _isLoading
                        ? CupertinoActivityIndicator()
                        : Text(
                            AppLocalization.of(context).translate("confirm")),
                  )),
              SizedBox(
                height: 17,
              ),
              IgnorePointer(
                ignoring: _isIgonre,
                child: FlatButton(
                    onPressed: () => _resendCode(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalization.of(context).translate("resend"),
                          style: TextStyle(
                            fontFamily: 'DIN Next LT Arabic',
                            fontSize: 16,
                            color: orange.withOpacity(0.68),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          width: 13,
                        ),
                        CounterDown(
                          animation: StepTween(
                            begin: levelClock, // THIS IS A USER ENTERED NUMBER
                            end: 0,
                          ).animate(_controller),
                        ),
                      ],
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _submitCode() async {
    FocusScope.of(context).unfocus();
    try {
      setState(() => _isLoading = true);
      var body = {
        "phone": widget.phone.toString(),
        "member_case": widget.memberCase,
        "code": _code.text.trim()
      };
      final response = await AppApi.authClient.verifyCode(body);
      if (response != null) {
        _updateUserInfo(response, context);
        _updateFcmToken(Helper.fcmToken, context);
      }
    } catch (err) {
      _showError(err.toString());
    }
  }

  void _updateUserInfo(User user, BuildContext context) {
    UtilSharedPreferences.setString('token', "Bearer " + user.token);
    UtilSharedPreferences.setObj('user', user.$UserToJson(user));
    ScopedModel.of<RestaurantsApiModel>(context).changeUser(user);
  }

  void _updateFcmToken(String newToken, BuildContext context) async {
    try {
      var _body = {"fcm_token": newToken};
      await AppApi.authClient.updateFcmToken(_body);
      var _count = 0;
      Navigator.pushNamedAndRemoveUntil(
          context, '/home', (route) => _count++ == 2);
    } catch (err) {
      _showError(err.toString());
    }
  }

  void _resendCode() async {
    _controller.forward();
    setState(() => _isIgonre = true);
    if (levelClock == 0) {
      _isIgonre = false;
    }

    var body = {
      "phone": widget.phone.toString(),
    };
    // await ScopedModel.of<RestaurantsApiModel>(context).loginUser(body,'eats/auth/resend_activation_code').then((value){
    //
    //
    // });
  }

  void _showError(String err) {
    setState(() => _isLoading = false);
    AppDialog.showMe(context, err.toString());
  }
}
