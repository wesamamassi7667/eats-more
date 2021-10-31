import 'package:eat_more_app/api/http_manager.dart';
import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:eat_more_app/model/check_out_response.dart';
import 'package:eat_more_app/model/my_myfatoorah_response.dart';
import 'package:eat_more_app/model/rajhi_response.dart';
import 'package:myfatoorah_flutter/model/initpayment/SDKInitiatePaymentResponse.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

class CheckOutClient {
  Future<CheckOut> listPayment(int vendorId, body) async {
    try {
      final response = await HttpManager.post<CheckOut>(
          'auth/orders/checkout?vendor_id=$vendorId',
          body,
          (json) => CheckOut.fromJson(json));
      return response;
    } catch (err) {
      throw (err);
    }
  }

  Future<MyFatoorah> getTokenAndUrl(int vendorId) async {
    try {
      final response = await HttpManager.get<MyFatoorah>(
          'auth/payment/myfatoorah-auth?vendor_id=$vendorId',
          (json) => MyFatoorah.fromJson(json));
      return response;
    } catch (err) {
      throw (err);
    }
  }

  Future<List<PaymentMethods>> initialMyFatoorhSdk(
      double total, double deliveryCost, String url, String token) async {
    List<PaymentMethods> paymentMethods = [];
    MFSDK.init(url, token);
    var request = MFInitiatePaymentRequest(
        total + deliveryCost, MFCurrencyISO.SAUDI_ARABIA_SAR);
    MFSDK.initiatePayment(
        request,
        MFAPILanguage.AR,
        (MFResult<MFInitiatePaymentResponse> result) => {
              if (result.isSuccess())
                {
                  print(result.response.toJson().toString()),
                  if (result.response != null)
                    {
                      paymentMethods
                          .addAll(result.response.paymentMethods ?? [])
                    }
                }
              else
                {print(result.error.message)}
            });
    return paymentMethods;
  }

  Future<Coupon> applyCoupon(int vendorId, body) async {
    try {
      final response = await HttpManager.post<Coupon>(
          'auth/coupon/check?vendor_id=$vendorId',
          body,
          (json) => Coupon.fromJson(json));
      return response;
    } catch (err) {
      throw (err);
    }
  }


  Future<String> getRajhiToken() async {
    try {
      final response = await HttpManager.get<RajhiAuth>(
          'auth/payment/Rajhi-GenerateOAuth',
              (json) => RajhiAuth.fromJson(json));
      return response?.access_token??"";
    } catch (err) {
      throw (err);
    }
  }

  Future<RajhiPayment> checkMobileRajhi(body,String token) async {
    try {
      final response = await HttpManager.post<RajhiPayment>(
          'auth/payment/Rajhi-checkMobile',
               body,
              (json) => RajhiPayment.fromJson(json),
              token: token
      );
      return response;
    } catch (err) {
      throw (err);
    }
  }

  Future<MyFatoorahPayment> paymentByMyFatoorah(body,int vendorId) async {
    // try {
      final response = await HttpManager.post<MyFatoorahPayment>(
          'auth/payment/myfatoorah-handler?vendor_id=$vendorId',
          body,
              (json) => MyFatoorahPayment .fromJson(json),
      );
      return response;
    // } catch (err) {
    //   throw (err);
    // }
  }
  }





