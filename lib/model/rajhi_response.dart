
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class RajhiAuth {
  String token_type;
  String access_token;
  RajhiAuth(this.token_type, this.access_token);
  factory RajhiAuth.fromJson(Map<String, dynamic> json) =>
      RajhiAuth(
        json['token_type'] as String,
        json['access_token'] as String,
      );
}

@JsonSerializable()
class RajhiPayment {
  TitleRajhi title;
  String priceBeforeDiscount;
  String couponDiscountAmount;
  String finalPrice;

  RajhiPayment(this.title, this.priceBeforeDiscount, this.couponDiscountAmount,
      this.finalPrice);
  factory RajhiPayment.fromJson(Map<String, dynamic> json) =>
      RajhiPayment(
        json['title'] == null
            ? null
            : TitleRajhi.fromJson(json['title'] as Map<String, dynamic>),
        json['priceBeforeDiscount'] as String,
        json['couponDiscountAmount'] as String,
        json['finalPrice'] as String,
      );
}
@JsonSerializable()
class TitleRajhi {
  String message;
  int status;
  OTP otp;
  String requestID;

  TitleRajhi(this.message, this.status, this.requestID,this.otp);
  factory TitleRajhi.fromJson(Map<String, dynamic> json) =>
      TitleRajhi(
        json['message'] as String,
        json['status'] as int,
        json['requestID'] as String,
        json['otp'] == null
            ? null
            : OTP.fromJson(json['otp'] as Map<String, dynamic>),
      );
}

@JsonSerializable()
class OTP {
  String currency;
  String otp_token_expired_in_min;
  String otp_token;

  OTP(this.currency, this.otp_token_expired_in_min, this.otp_token);
  factory OTP.fromJson(Map<String, dynamic> json) =>
      OTP(
        json['currency'] as String,
        json['otp_token_expired_in_min'] as String,
        json['otp_token'] as String,
      );
}

@JsonSerializable()
class CheckOtpCode {
  String message;
  int status;
  int transactionID;
  CheckOtpCode(this.message, this.status, this.transactionID);
  factory CheckOtpCode.fromJson(Map<String, dynamic> json) =>
      CheckOtpCode(
        json['message'] as String,
        json['status'] as int,
        json['transactionID'] as int,
      );
}
