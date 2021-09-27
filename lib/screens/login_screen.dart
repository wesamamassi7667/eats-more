import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/app_theme.dart';
import 'package:eat_more_app/screens/verification_code_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../color.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode _numberFocusNode;
  TextEditingController _number = new TextEditingController();
  var _isLoading = false;

  @override
  void initState() {
    _numberFocusNode = new FocusNode();
    if (!kReleaseMode) {
      _number.text = "591591592";
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //make keyboard above container

      body: Stack(
        children: [
          Container(
            // height: MediaQuery.of(context).size.height,
            margin: EdgeInsetsDirectional.only(top: 142, bottom: 45),
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
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 69.2,
                ),
                SvgPicture.asset('assets/images/login.svg'),
                SizedBox(height: 29.5),
                Text(
                  AppLocalization.of(context)
                      .translate("enter_your_mobile_number_to_log in"),
                  style: TextStyle(
                    fontFamily: 'DIN Next LT Arabic',
                    fontSize: 17,
                    color: black4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 47,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Padding(
                    padding: EdgeInsets.only(left: 79, right: 78.5),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          child: TextField(
                            textAlign: TextAlign.right,
                            enabled: false,
                            decoration: InputDecoration(
                                hintText: "+966",
                                hintStyle: TextStyle(
                                    fontFamily: 'DIN Next LT Arabic',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: black4),
                                suffixIcon: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: black2,
                                  // size: 15,
                                )),
                          ),
                        ),
                        SizedBox(width: 15.9),
                        Expanded(
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            textDirection: TextDirection.ltr,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            focusNode: _numberFocusNode,
                            controller: _number,
                            onFieldSubmitted: (s) {
                              _numberFocusNode.unfocus();
                              FocusScope.of(context).unfocus();
                            },
                            decoration: InputDecoration(
                              hintText: AppLocalization.of(context)
                                  .translate("mobile_number"),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: green.withOpacity(0.07),
                              )),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: green.withOpacity(0.07),
                              )),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: green.withOpacity(0.07),
                              )),
                              hintStyle: TextStyle(
                                fontFamily: 'DIN Next LT Arabic',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: black2.withOpacity(0.76),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 34.5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.688,
                  child: OutlinedButton(
                    onPressed: (){
                      if (_number.text.trim().isEmpty)
                        AppDialog.showMe(
                            context,
                            AppLocalization.of(context)
                                .translate("you_must_enter_your_mobile_number"));
                      else
                        _login();
                    },
                    child:_isLoading?CupertinoActivityIndicator(): Text( AppLocalization.of(context).translate("sign_up")),
                    style: AppThemeData.buttonStyle(fontSize: 18),

                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _login() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });
    var _body = {"phone": "966" + _number.text.trim()};
    await ScopedModel.of<RestaurantsApiModel>(context)
        .loginUser(_body, 'auth/login')
        .then((value) async {
      if (value.status.status) {
        final signature = await SmsAutoFill().getAppSignature;
        print(signature);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerificationCodeScreen(
                      phone: value.data.phone,
                      memberCase: value.data.member_case,
                    )));
      } else {
        AppDialog.showMe(context, value.status.HTTP_response, isError: true);
      }
      setState(() {
        _isLoading = false;
      });
    });
  }
}
