
import 'package:eat_more_app/model/stauts.dart';
import 'package:json_annotation/json_annotation.dart';
part 'rajhi_response.g.dart';

@JsonSerializable()
class RajhiResponse{
  StatusResponse status;
  RajhiAuth data;

  RajhiResponse(this.status, this.data);
  factory RajhiResponse.fromJson(Map<String, dynamic> json) =>
      _$RajhiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RajhiResponseToJson(this);
}

@JsonSerializable()
class RajhiAuth {
  String token_type;
  String access_token;
  RajhiAuth(this.token_type, this.access_token);
  factory RajhiAuth.fromJson(Map<String, dynamic> json) =>
      _$RajhiAuthFromJson(json);

  Map<String, dynamic> toJson() => _$RajhiAuthToJson(this);
}

@JsonSerializable()
class RajhiPaymentResponse{
  StatusResponse status;
  RajhiPayment data;

  RajhiPaymentResponse(this.status, this.data);

  factory RajhiPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$RajhiPaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RajhiPaymentResponseToJson(this);
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
      _$RajhiPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$RajhiPaymentToJson(this);
}
@JsonSerializable()
class TitleRajhi {
  String message;
  int status;
  OTP otp;
  String requestID;

  TitleRajhi(this.message, this.status, this.requestID,this.otp);
  factory TitleRajhi.fromJson(Map<String, dynamic> json) =>
      _$TitleRajhiFromJson(json);

  Map<String, dynamic> toJson() => _$TitleRajhiToJson(this);
}

@JsonSerializable()
class OTP {
  String currency;
  String otp_token_expired_in_min;
  String otp_token;

  OTP(this.currency, this.otp_token_expired_in_min, this.otp_token);
  factory OTP.fromJson(Map<String, dynamic> json) =>
      _$OTPFromJson(json);

  Map<String, dynamic> toJson() => _$OTPToJson(this);
}

@JsonSerializable()
class CheckOtpCodeResponse{
  StatusResponse status;
  CheckOtpCode data;

  CheckOtpCodeResponse(this.status, this.data);
  factory CheckOtpCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckOtpCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckOtpCodeResponseToJson(this);
}
@JsonSerializable()
class CheckOtpCode {
  String message;
  int status;
  int transactionID;
  CheckOtpCode(this.message, this.status, this.transactionID);
  factory CheckOtpCode.fromJson(Map<String, dynamic> json) =>
      _$CheckOtpCodeFromJson(json) ;

  Map<String, dynamic> toJson() => _$CheckOtpCodeToJson(this);
}
