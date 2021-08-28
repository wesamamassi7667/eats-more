// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponse _$CartResponseFromJson(Map<String, dynamic> json) {
  return CartResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : Cart.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CartResponseToJson(CartResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Cart _$CartFromJson(Map<String, dynamic> json) {
  return Cart(
    (json['products_price'] as num)?.toDouble(),
    json['products_count'] as int,
    json['order_id'] as int,
    (json['products'] as List)
        ?.map((e) =>
            e == null ? null : ProductCart.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'products_price': instance.products_price,
      'products_count': instance.products_count,
      'order_id': instance.order_id,
      'products': instance.products,
    };

ProductCart _$ProductCartFromJson(Map<String, dynamic> json) {
  return ProductCart(
    json['basket_product_id'] as int,
    json['custom_addons'] as String,
    json['product_id'] as int,
    json['product_name'] as String,
    json['product_image'] as String,
    json['quantity'] as int,
    (json['one_product_price'] as num)?.toDouble(),
    json['product_addons_price'] as String,
    json['final_price'] as String,
    json['product_offer'] == null
        ? null
        : ProductOffer.fromJson(json['product_offer'] as Map<String, dynamic>),
    (json['addons'] as List)
        ?.map((e) =>
            e == null ? null : Addons.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['image'] as String,
    (json['addon'] as List)
        ?.map((e) =>
            e == null ? null : Addons.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProductCartToJson(ProductCart instance) =>
    <String, dynamic>{
      'basket_product_id': instance.basket_product_id,
      'custom_addons': instance.custom_addons,
      'product_id': instance.product_id,
      'product_name': instance.product_name,
      'product_image': instance.product_image,
      'quantity': instance.quantity,
      'one_product_price': instance.one_product_price,
      'product_addons_price': instance.product_addons_price,
      'final_price': instance.final_price,
      'product_offer': instance.product_offer,
      'addons': instance.addons,
      'image': instance.image,
      'addon': instance.addon,
    };
