import 'package:eat_more_app/api/app_api.dart';
import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/component/mobile_text_field.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../color.dart';

class CodeArguments {
  final String phone;
  final String memberCase;

  CodeArguments(this.phone, this.memberCase);
}

class LoginScreen extends StatefulWidget {
  final bool isSheet;

  const LoginScreen({Key key, this.isSheet = false}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _number = new TextEditingController();
  var _isLoading = false;

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
                    fontSize: 17,
                    color: black4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 47,
                ),
                MobileTextField(
                  controller: _number,
                ),
                SizedBox(
                  height: 34.5,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: OutlinedButton(
                    onPressed: () {
                      if (_number.text.trim().isEmpty) {
                        String message = AppLocalization.of(context)
                            .translate("you_must_enter_your_mobile_number");
                        AppDialog.showMe(context, message);
                      } else {
                        _login();
                      }
                    },
                    child: _isLoading
                        ? CupertinoActivityIndicator()
                        : Text(
                            AppLocalization.of(context).translate("sign_up")),
                    style: AppThemeData.buttonStyle(fontSize: 18),
                  ),
                ),
                widget.isSheet
                    ? SizedBox.shrink()
                    : TextButton(
                        child: Text(
                            AppLocalization.of(context).translate('visitor')),
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, '/home'),
                        style: AppThemeData.textButtonStyle(
                            backgroundColor: Colors.transparent,
                            primary: primaryIconColor),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    if (!kReleaseMode) {
      _number.text = "591591592";
    }
    // TODO: implement initState
    super.initState();
  }

  void _login() async {
    FocusScope.of(context).unfocus();
    try{
      setState(() => _isLoading = true);
      var _body = {"phone": "966" + _number.text.trim()};
      final response=await AppApi.authClient.loginUser(_body);
      if(response!=null){
        setState(() =>_isLoading=false);
        Navigator.pushNamed(context, '/code', arguments: {
          'phone':response.phone,
          'member_case': response.member_case
        });
      }
    }
    catch(err){
      setState(() => _isLoading = false);
      AppDialog.showMe(context, err.toString());
    }
  }
}
