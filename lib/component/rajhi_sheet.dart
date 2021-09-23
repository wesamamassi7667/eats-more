import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../color.dart';
import 'app_text_field.dart';
import 'close_button_sheet.dart';

class RajhiSheet extends StatefulWidget {
  final double total;

  const RajhiSheet({Key key, this.total}) : super(key: key);

  @override
  _RajhiSheetState createState() => _RajhiSheetState();
}

class _RajhiSheetState extends State<RajhiSheet> {
  FocusNode _mobileFocusNode = new FocusNode();
  TextEditingController _mobile = new TextEditingController();
  TextEditingController _discount = new TextEditingController();
  var _isLoading = false;
  var _isLoading1 = false;
  var _token = "";
  var _showSecond = false;

  @override
  void initState() {
    _mobile.text = '+966';
    // TODO: implement initState
    super.initState();
    _getToken();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      child: AnimatedCrossFade(
        crossFadeState:
        _showSecond ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 400),
        firstChild: Container(
          height: 290,
          child: _isLoading
              ? Center(child: CupertinoActivityIndicator(),)
              : SingleChildScrollView(
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
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 33),
                    child: APPTextField(
                      hintText: AppLocalization.of(context)
                          .translate("mobile_number"),
                      focusNode: _mobileFocusNode,
                      nextFocus: null,
                      textEditingController: _mobile,
                      textType: TextInputType.phone,
                      prifexIcon: Icon(
                        Icons.phone,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 33),
                  child: ElevatedButton(
                    child: Text(AppLocalization.of(context).translate("add")),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        _showSecond = true;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        secondChild: Container(
          height: 300,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CloseButtonSheet(),
                  ],
                ),
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
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 33.0),
                  child: Text(
                    AppLocalization.of(context).translate('discount'),
                    style: TextStyle(
                        fontFamily: 'DIN Next LT Arabic',
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 100,
                  height: 54,
                  margin: EdgeInsetsDirectional.only(start: 33),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: grey11,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                            controller: _discount,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          )),
                      Text(
                        AppLocalization.of(context).translate('sr'),
                        style: TextStyle(
                            fontFamily: 'DIN Next LT Arabic', fontSize: 18),
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
                  child: ElevatedButton(
                    child: _isLoading?CupertinoActivityIndicator():Text(AppLocalization.of(context).translate("confirm")),
                    onPressed: () {
                      _paymentRajhi();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _getToken() async {
    setState(() {
      _isLoading = true;
    });
    await ScopedModel.of<RestaurantsApiModel>(context)
        .getTokenRajhi()
        .then((value) {
      if (value.status.status) {
        _token = value.data.access_token;
        print(_token);
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _paymentRajhi() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading1 = true;
    });
    var _body = {
      "mobileRajhi": _mobile.text.trim(),
      "amount": widget.total.toString(),
      "currency": "SAR",
      "lang":UtilSharedPreferences.getInt('lang').toString(),
      "discount" :_discount.text.trim(),
      "type":"coupon"};
    await ScopedModel.of<RestaurantsApiModel>(context).paymentRajhi(
        _token, _body).then((value) {
       if(value.data.title.status==200){
         Navigator.pop(context,[value.data.couponDiscountAmount,value.data.finalPrice," ",value.data.title.otp.otp_token,_token]);}
      else{
      Navigator.pop(context);
      AppDialog.showMe(context, value.data.title.message);}
       if(mounted)
       setState(() {
         _isLoading1 = false;
       });

    });
  }
}
