import 'package:eat_more_app/api/app_api.dart';
import 'package:eat_more_app/component/address_check_out.dart';
import 'package:eat_more_app/component/check_out_appbar.dart';
import 'package:eat_more_app/component/common/common.dart';
import 'package:eat_more_app/component/my_progress_indicator.dart';
import 'package:eat_more_app/helper/helper.dart';
import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:eat_more_app/model/arguments/check_out_argument.dart';
import 'package:eat_more_app/model/cart_response.dart';
import 'package:eat_more_app/model/check_out_response.dart';
import 'package:eat_more_app/model/my_myfatoorah_response.dart';
import 'package:eat_more_app/screens/bottom_check_out.dart';
import 'package:eat_more_app/widgets/cart_list.dart';
import 'package:eat_more_app/widgets/coupon_widget.dart';
import 'package:eat_more_app/widgets/empty_widget_column.dart';
import 'package:eat_more_app/widgets/payment_method_widget.dart';
import 'package:eat_more_app/widgets/success_order_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfatoorah_flutter/model/executepayment/MFExecutePaymentRequest.dart';
import 'package:myfatoorah_flutter/model/initpayment/SDKInitiatePaymentResponse.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

class CheckOutScreen extends StatefulWidget {
  final CheckOutArgument arguments;
  const CheckOutScreen(this.arguments, {Key key}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  CheckOutArgument _checkOutArgument;
  final List<Payment> _paymentsType = [];
  final List<Payment> _typesCoupon = [];
  List<PaymentMethods> _paymentMethods = [];
  String paymentId;
  String paymentKey;
  var _isLoading = false;
  var _discountAmount = "";
  var _length;
  var _couponCode;
  double priceWithCoupn;

  @override
  void initState() {
    _checkOutArgument = widget.arguments;
    _paymentMethods = [];
    _length = _checkOutArgument.carts.length;

    // TODO: implement initState
    super.initState();
    _getPaymentType();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _back(),
      child: Scaffold(
        appBar: CheckOutAppBar(
          tapClose: () => _back(),
        ),
        bottomSheet: CheckOutBottom(
          press: () {
            if (paymentKey == 'visa') {
              _executePayment();
            } else {
              _makeOrder();
            }
          },
          length: _length,
          discountAmount: _discountAmount,
          vat: _checkOutArgument.vat,
          vatNo: _checkOutArgument.vatNo,
          carts: _checkOutArgument.carts,
          totalPrice: _checkOutArgument.total,
          totalPriceWithCoupon: priceWithCoupn,
        ),
        body: _isLoading
            ? MyProgressIndicator()
            : _checkOutArgument.carts.isEmpty
                ? EmptyWidgetColumn(
                    message: 'no_items_added_cart',
                    icon: CupertinoIcons.cart,
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 120.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          AddressCheckOutWidget(
                              branch: _checkOutArgument.branch,
                              address: _checkOutArgument.address),
                          SizedBox(
                            height: 10,
                          ),
                          CartList(
                            carts: _checkOutArgument.carts,
                            updateCartCallBack: _updateCart,
                            vendorId: _checkOutArgument.id,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          PaymentMethodWidget(
                              paymentsType: _paymentsType,
                              paymentMethods: _paymentMethods,
                              callBack: _paymentTypeCallBack,
                              idCallBack:_paymentIdCallBack
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CouponWidget(
                            typesCoupon: _typesCoupon,
                            vendorId: _checkOutArgument.id,
                            updateCouponCallBack: _updateCouponCallBack,
                            total: _checkOutArgument.total,
                            nameWay: _checkOutArgument.idWay == 2
                                ? "pickup"
                                : "delivery",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }

  Future<void> _getCreditMethod() async {
    MyFatoorah data =
        await AppApi.checkOutClient.getTokenAndUrl(_checkOutArgument.id);
    if (data != null) {
      _paymentMethods = await AppApi.checkOutClient.initialMyFatoorhSdk(
          _checkOutArgument.total,
          _checkOutArgument.deliveryCost,
          data.base_url ?? "",
          data.token ?? "");
    }
    setState(() => _isLoading = false);
  }

  void _getPaymentType() async {
    setState(() => _isLoading = true);
    String type = _checkOutArgument.idWay == 1 ? "pickup" : "delivery";
    var _body = {"type": type};
    CheckOut response =
        await AppApi.checkOutClient.listPayment(_checkOutArgument.id, _body);
    if (response != null) {
      _typesCoupon.addAll(response.coupon_type ?? []);
      _paymentsType.addAll(response.payment_type ?? []);
    }
    _getCreditMethod();
  }

  _updateCart(List<ProductCart> carts, double finalPrice) {
    setState(() {
      _checkOutArgument.carts = carts;
      _checkOutArgument.total = finalPrice;
    });
  }

  _updateCouponCallBack(String finalPrice, String discount, String couponCode) {
    setState(() {
      priceWithCoupn = double.parse(finalPrice);
      _discountAmount = discount;
      _couponCode = couponCode;
    });
  }

  _paymentTypeCallBack(String keyPayment) {
    paymentKey = keyPayment;
  }

  _paymentIdCallBack(String idPaymentMethod){
    paymentId=idPaymentMethod;
    print(paymentId);
  }

  void _makeOrder() async {
    try {
      var _body = {
        "type": _checkOutArgument.idWay == 2 ? "pickup" : "delivery",
        "branchID": _checkOutArgument.branch.branch_id.toString(),
        "vendor_id": _checkOutArgument.id.toString(),
        "is_schedule": _checkOutArgument.time == null ||
                _checkOutArgument.time.trim().isEmpty
            ? false.toString()
            : true.toString(),
        "schedule_date":
            _checkOutArgument.time == null ? "" : _checkOutArgument.time,
        // "note": !_isChecked ? "" : 'اترك الطلب عند الباب',
        "long": _checkOutArgument.lng ?? "",
        "lat": _checkOutArgument.lat ?? "",
        "paymentType": paymentKey,
        "order_address": _checkOutArgument.address?.trim() ?? '',
        "transactionid": "",
        "addressID": "",
        "is_rajhi": "0",
        "invoicevalue": _discountAmount.isEmpty
            ? '${_checkOutArgument.total}'
            : '$priceWithCoupn',
      };
      print(_body);
      Common.showSingleAnimationDialog(context);
      String _orderNumber = await AppApi.orderClient.makeOrder(_body) ?? "";
      Navigator.pop(context);
      setState(() {
        _checkOutArgument.carts.clear();
        _checkOutArgument.total = 0.0;
      });
      Common.showModalBottom(
          context, OrderSuccessWidget(orderNumber: _orderNumber),
          isScrollControlled: false);
    } catch (err) {
      Common.showError(err, context);
    }
  }

  Future<bool> _back() {
    Navigator.pop(
        context, AddCart(_checkOutArgument.carts, _checkOutArgument.total));
  }


  Future<void> _executePayment() async {
    // try{
      var body = {
        "type": _checkOutArgument.idWay == 2 ? "pickup" : "delivery",
        "is_rajhi": "",
        "invoicevalue": _discountAmount.isEmpty
            ? '${_checkOutArgument.total}'
            : '$priceWithCoupn',
        "is_qitaf": false.toString(),
        "couponCode": _couponCode ?? "",
      };
      print(body);
      Common.showSingleAnimationDialog(context);
      MyFatoorahPayment response = await AppApi.checkOutClient
          .paymentByMyFatoorah(body, _checkOutArgument.id);
      if (response != null) {
        // for(Supplier s in response.Suppliers){
        //   s.invoiceShare= s.invoiceShare.toDouble();
        // }
        // print("smsm "+response.Suppliers.toString());
        var request = new MFExecutePaymentRequest(
            int.parse(paymentId),
            _discountAmount.isNotEmpty
                ? priceWithCoupn + _checkOutArgument.deliveryCost
                : _checkOutArgument.total + _checkOutArgument.deliveryCost);
        request.paymentMethodId = int.parse(paymentId);
        request.customerEmail = response.CustomerEmail;
        request.customerMobile = response.CustomerMobile;
        request.customerName = response.CustomerName;
        request.customerReference = response.CustomerReference.toString();
        // request.invoiceItems = response.InvoiceItems;
        // request.suppliers = response.Suppliers;
        // request.invoiceValue = response.InvoiceValue;
        request.userDefinedField = response.UserDefinedField;
        request.mobileCountryCode = response.MobileCountryCode;
        request.language =
        UtilSharedPreferences.getInt('lang') == 0 ? 'en' : "ar";
        MFSDK.executePayment(
            context,
            request,
            MFAPILanguage.EN,
                (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
              if (result.isSuccess())
                {_makeOrder()}
              else
                {
                  print(result.error.message),
                  Navigator.pop(context)
                }
            });
      }
    // }
    // catch(err){
    //   Common.showError(err, context);
    // }
  }
}
