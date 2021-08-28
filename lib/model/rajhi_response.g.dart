// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rajhi_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RajhiResponse _$RajhiResponseFromJson(Map<String, dynamic> json) {
  return RajhiResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : RajhiAuth.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RajhiResponseToJson(RajhiResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

RajhiAuth _$RajhiAuthFromJson(Map<String, dynamic> json) {
  return RajhiAuth(
    json['token_type'] as String,
    json['access_token'] as String,
  );
}

Map<String, dynamic> _$RajhiAuthToJson(RajhiAuth instance) => <String, dynamic>{
      'token_type': instance.token_type,
      'access_token': instance.access_token,
    };

RajhiPaymentResponse _$RajhiPaymentResponseFromJson(Map<String, dynamic> json) {
  return RajhiPaymentResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : RajhiPayment.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RajhiPaymentResponseToJson(
        RajhiPaymentResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

RajhiPayment _$RajhiPaymentFromJson(Map<String, dynamic> json) {
  return RajhiPayment(
    json['title'] == null
        ? null
        : TitleRajhi.fromJson(json['title'] as Map<String, dynamic>),
    json['priceBeforeDiscount'] as String,
    json['couponDiscountAmount'] as String,
    json['finalPrice'] as String,
  );
}

Map<String, dynamic> _$RajhiPaymentToJson(RajhiPayment instance) =>
    <String, dynamic>{
      'title': instance.title,
      'priceBeforeDiscount': instance.priceBeforeDiscount,
      'couponDiscountAmount': instance.couponDiscountAmount,
      'finalPrice': instance.finalPrice,
    };

TitleRajhi _$TitleRajhiFromJson(Map<String, dynamic> json) {
  return TitleRajhi(
    json['message'] as String,
    json['status'] as int,
    json['requestID'] as String,
    json['otp'] == null
        ? null
        : OTP.fromJson(json['otp'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TitleRajhiToJson(TitleRajhi instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'otp': instance.otp,
      'requestID': instance.requestID,
    };

OTP _$OTPFromJson(Map<String, dynamic> json) {
  return OTP(
    json['currency'] as String,
    json['otp_token_expired_in_min'] as String,
    json['otp_token'] as String,
  );
}

Map<String, dynamic> _$OTPToJson(OTP instance) => <String, dynamic>{
      'currency': instance.currency,
      'otp_token_expired_in_min': instance.otp_token_expired_in_min,
      'otp_token': instance.otp_token,
    };

CheckOtpCodeResponse _$CheckOtpCodeResponseFromJson(Map<String, dynamic> json) {
  return CheckOtpCodeResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : CheckOtpCode.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CheckOtpCodeResponseToJson(
        CheckOtpCodeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

CheckOtpCode _$CheckOtpCodeFromJson(Map<String, dynamic> json) {
  return CheckOtpCode(
    json['message'] as String,
    json['status'] as int,
    json['transactionID'] as int,
  );
}

Map<String, dynamic> _$CheckOtpCodeToJson(CheckOtpCode instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'transactionID': instance.transactionID,
    };
