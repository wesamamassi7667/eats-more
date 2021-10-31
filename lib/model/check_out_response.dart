
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CheckOut {
  List<Payment> payment_type;
  List<Payment> coupon_type;

  CheckOut(this.payment_type,this.coupon_type);
  factory CheckOut.fromJson(Map<String, dynamic> json) =>
      CheckOut(
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

@JsonSerializable()
class Payment {
  String key;
  String value;
  String image;

  Payment(this.key, this.value,this.image);
  factory Payment.fromJson(Map<String, dynamic> json) =>
   Payment(
      json['key'] as String,
      json['value'] as String,
      json['image'] as String,
  );
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
      Coupon(
        json['couponCode'] as String,
        json['couponId'] as int,
        json['title'] as String,
        json['priceBeforeDiscount'] as String,
        json['couponDiscountAmount'] as String,
        json['finalPrice'] as String,
      );

}

