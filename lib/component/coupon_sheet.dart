import 'package:eat_more_app/api/app_api.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/component/mobile_text_field.dart';
import 'package:eat_more_app/component/my_progress_indicator.dart';
import 'package:eat_more_app/component/row_buttons.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:eat_more_app/model/arguments/rajhi_rgument.dart';
import 'package:eat_more_app/model/check_out_response.dart';
import 'package:eat_more_app/widgets/coupon_payment_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'common/common.dart';
import 'cupertinoTextField.dart';

class CouponSheet extends StatefulWidget {
  final List<Payment> types;
  final int id;
  final String type;
  final double total;

  const CouponSheet({Key key, this.types, this.id, this.type, this.total}) : super(key: key);
  @override
  _CouponSheetState createState() => _CouponSheetState();
}

class _CouponSheetState extends State<CouponSheet> {
  // FocusNode _codeFocusNode = new FocusNode();
  TextEditingController _controller = new TextEditingController();
  TextEditingController _discount = new TextEditingController();

  final duration = Duration(milliseconds: 300);
  String _selectedKeyCoupon = "";
  var _isRajhi = false;
  String _token;
  var _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery
            .of(context)
            .viewInsets
            .bottom),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 33.0, 16.0, 30.0),
          child: _isLoading?MyProgressIndicator():Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  AppLocalization.of(context).translate('more_coupon'),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
              SizedBox(height: 20.6,),
              CouponPaymentList(
                  coupons: widget.types,
                  isCoupon: true, callBack: this._updateKeyCoupon),
              SizedBox(height: _isRajhi ? 17.5 : 48,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: CupertinoField(
                    controller: _controller,
                    hint: _isRajhi ?
                    AppLocalization.of(context).translate('mobile_number') :
                    AppLocalization.of(context).translate('coupon_code'),
                   // : _isRajhi?Text("+966"):null,
                ),
              ),
              AnimatedContainer(
                  duration: duration,
                  height: _isRajhi ? 13 : 0,
                  child: SizedBox()
              ),
              _isRajhi ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                width: 100,
                child: CupertinoField(
                  controller: _discount,
                  hint: AppLocalization.of(context).translate(
                      'discount_amount'),
                  fontSize: 10,
                  suffix: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 13.0),
                    child: Text(AppLocalization.of(context).translate('sr')),
                  ),
                ),
              ) : SizedBox.shrink(),
              AnimatedContainer(
                  duration: duration,
                  height: _isRajhi ? 40 : 54,
                  child: SizedBox()),
              RowButtons(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.4,
                text1: AppLocalization.of(context).translate('activate_code'),
                text2: AppLocalization.of(context).translate('cancel'),
                pressFirst: () {
                  if (_selectedKeyCoupon.trim() == 'rajhi') {
                   _paymentRajhi();
                  }
                },
                pressSecond: () => Navigator.pop(context),
              )

            ],
          ),
        ),
      ),

    );
  }

  _updateKeyCoupon(String key) {
    setState(() => _selectedKeyCoupon = key);
    if (_selectedKeyCoupon.trim() == 'rajhi') {
      setState(() => _isRajhi = true);
    }
    else {
      setState(() => _isRajhi = false);
    }
  }

  void _getToken() async {
    setState(() =>_isLoading=true);
    var response = await AppApi.checkOutClient.getRajhiToken();
    if (response != null) {
      _token = response;
      print("soma " +_token);
    }
    setState(() =>_isLoading=false);
  }

  void _paymentRajhi() async {
    try{
      var _body = {
        "mobileRajhi": "+966"+ _controller.text.trim(),
        "amount": widget.total.toString(),
        "currency": "SAR",
        "lang": UtilSharedPreferences.getInt('lang')==0?"en":"ar",
        "discount": _discount.text.trim(),
        "type": "coupon"
      };
      print(_body);
      Common.showSingleAnimationDialog(context);
      final response = await AppApi.checkOutClient.checkMobileRajhi(_body, _token);
      Navigator.pop(context);
      if (response != null) {
        if(response.title.status==200){
          RajhiArgument _rajhiArgument=RajhiArgument(response.couponDiscountAmount,double.parse(response.finalPrice),
              _token, response.title.otp.otp_token);
          Navigator.pop(context,_rajhiArgument);
        }
        else{
          AppDialog.showMe(context,response.title.message);
        }
      }
    }
    catch(err){
      Common.showError(err, context);
    }
  }
}


//     await ScopedModel.of<RestaurantsApiModel>(context).paymentRajhi(
//         _token, _body).then((value) {
//       if(value.data.title.status==200){
//         Navigator.pop(context,[value.data.couponDiscountAmount,value.data.finalPrice," ",value.data.title.otp.otp_token,_token]);}
//       else{
//         Navigator.pop(context);
//         AppDialog.showMe(context, value.data.title.message);}
//       if(mounted)
//         setState(() {
//           _isLoading1 = false;
//         });
//
//     });
//   }
//
// }




