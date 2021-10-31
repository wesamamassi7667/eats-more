import 'package:eat_more_app/api/app_api.dart';
import 'package:eat_more_app/component/common/common.dart';
import 'package:eat_more_app/component/container_component.dart';
import 'package:eat_more_app/component/coupon_sheet.dart';
import 'package:eat_more_app/component/cupertinoTextField.dart';
import 'package:eat_more_app/helper/app_localization.dart';
import 'package:eat_more_app/helper/app_theme.dart';
import 'package:eat_more_app/model/check_out_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../color.dart';

class CouponWidget extends StatefulWidget {
  final List<Payment> typesCoupon;
  final int vendorId;
  final double total;
  final String nameWay;
  final Function updateCouponCallBack;

  const CouponWidget(
      {Key key, this.typesCoupon, this.vendorId, this.updateCouponCallBack, this.total, this.nameWay})
      : super(key: key);
  @override
  _CouponWidgetState createState() => _CouponWidgetState();
}

class _CouponWidgetState extends State<CouponWidget> with TickerProviderStateMixin{
  final TextEditingController _controller = new TextEditingController();
  bool _isApplied = false;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this,duration: Duration(seconds: 2));

    // TODO: implement initState
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SecondContainerComponent(
      topP: 13,
      startP: 15,
      endP: 15,
      radius: BorderRadius.circular(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalization.of(context).translate('discount_coupon'),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Flexible(
                child: CupertinoField(
                  isEnabled: _isApplied?false:true,
                  inputType: TextInputType.text,
                  hint: AppLocalization.of(context).translate('coupon_code'),
                  controller: _controller,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 100,
                child: _isApplied
                    ? TextButton.icon(
                        onPressed: () {},
                        icon: Lottie.asset('assets/json/done.json',
                             height: 25, width: 25,repeat: false,

                        ),
                        label: Text('Applied'),
                     style: AppThemeData.textButtonStyle(borderRadius: 10),
                   )
                    : OutlinedButton(
                        child:
                        Text(AppLocalization.of(context).translate('apply')),
                        onPressed: () => _applyCoupon(context),
                        style: AppThemeData.buttonStyle(borderRadius: 10),
                      ),
              ),
            ],
          ),
        _isApplied?SizedBox.shrink():  Center(
            child: TextButton(
                onPressed: () {
                  Common.showModalBottom(
                      context,
                      CouponSheet(
                        types: widget.typesCoupon,
                        total: widget.total,
                      )
                  );
                },
                style: AppThemeData.textButtonStyle(
                    backgroundColor: Colors.transparent),
                child: Column(
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: grey15,
                    ),
                    Text(
                      AppLocalization.of(context).translate('more_coupon'),
                      style: TextStyle(
                        fontSize: 9,
                        color: grey15,
                      ),
                    )
                  ],
                )),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void _applyCoupon(context) async {
    try {
      FocusScope.of(context).unfocus();
      Common.showSingleAnimationDialog(context);
      var _body = {
        "code_coupon": _controller.text.trim(),
        "type": widget.nameWay,
      };
      final response = await AppApi.checkOutClient.applyCoupon(widget.vendorId, _body);
      Navigator.pop(context);
      if (response != null) {
        setState(() => _isApplied = true);
        widget.updateCouponCallBack(
            response.finalPrice, response.couponDiscountAmount,_controller.text.trim());

      }
    } catch (err) {
      Common.showError(err, context);
    }
  }
}
