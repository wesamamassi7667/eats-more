
import 'package:eat_more_app/model/stauts.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_out_response.g.dart';
@JsonSerializable()
class CheckOutResponse{
  StatusResponse status;
  CheckOut data;

  CheckOutResponse(this.status, this.data);
  factory CheckOutResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckOutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckOutResponseToJson(this);
}
@JsonSerializable()
class CheckOut {
  List<Payment> payment_type;
  List<Payment> coupon_type;

  CheckOut(this.payment_type,this.coupon_type);
  factory CheckOut.fromJson(Map<String, dynamic> json) =>
      _$CheckOutFromJson(json);

  Map<String, dynamic> toJson() => _$CheckOutToJson(this);
}

@JsonSerializable()
class Payment {
  String key;
  String value;
  String image;

  Payment(this.key, this.value,this.image);
  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);

}

@JsonSerializable()
class CouponResponse{
  StatusResponse status;
 Coupon data;

  CouponResponse(this.status, this.data);
  factory CouponResponse.fromJson(Map<String, dynamic> json) =>
      _$CouponResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CouponResponseToJson(this);
}
@JsonSerializable()
class Coupon {
  String couponCode;
  int couponId;
  String title;
  String priceBeforeDiscount;
  String couponDiscountAmount;
  String finalPrice;

  Coupon(this.couponCode, this.couponId, this.title, this.priceBeforeDiscount,
      this.couponDiscountAmount, this.finalPrice);
  factory Coupon.fromJson(Map<String, dynamic> json) =>
      _$CouponFromJson(json);

  Map<String, dynamic> toJson() => _$CouponToJson(this);

}

