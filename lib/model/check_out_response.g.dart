// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_out_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOutResponse _$CheckOutResponseFromJson(Map<String, dynamic> json) {
  return CheckOutResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : CheckOut.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CheckOutResponseToJson(CheckOutResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

CheckOut _$CheckOutFromJson(Map<String, dynamic> json) {
  return CheckOut(
    (json['payment_type'] as List)
        ?.map((e) =>
            e == null ? null : Payment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['coupon_type'] as List)
        ?.map((e) =>
            e == null ? null : Payment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CheckOutToJson(CheckOut instance) => <String, dynamic>{
      'payment_type': instance.payment_type,
      'coupon_type': instance.coupon_type,
    };

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return Payment(
    json['key'] as String,
    json['value'] as String,
    json['image'] as String,
  );
}

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
      'image': instance.image,
    };

CouponResponse _$CouponResponseFromJson(Map<String, dynamic> json) {
  return CouponResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : Coupon.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CouponResponseToJson(CouponResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Coupon _$CouponFromJson(Map<String, dynamic> json) {
  return Coupon(
    json['couponCode'] as String,
    json['couponId'] as int,
    json['title'] as String,
    json['priceBeforeDiscount'] as String,
    json['couponDiscountAmount'] as String,
    json['finalPrice'] as String,
  );
}

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      'couponCode': instance.couponCode,
      'couponId': instance.couponId,
      'title': instance.title,
      'priceBeforeDiscount': instance.priceBeforeDiscount,
      'couponDiscountAmount': instance.couponDiscountAmount,
      'finalPrice': instance.finalPrice,
    };
