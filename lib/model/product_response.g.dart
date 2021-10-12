// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) {
  return ProductResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : Product.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

MenuResponse _$MenuResponseFromJson(Map<String, dynamic> json) {
  return MenuResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : Menu.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MenuResponseToJson(MenuResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Menu _$MenuFromJson(Map<String, dynamic> json) {
  return Menu(
    (json['products_menu'] as List)
        ?.map((e) =>
            e == null ? null : ProductInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'products_menu': instance.products_menu,
    };

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    json['product_info'] == null
        ? null
        : ProductInfo.fromJson(json['product_info'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'product_info': instance.product_info,
    };

ProductInfo _$ProductInfoFromJson(Map<String, dynamic> json) {
  return ProductInfo(
    json['product_id'] as int,
    json['product_name'] as String,
    json['image_preview'] as String,
    json['product_offer'] == null
        ? null
        : ProductOffer.fromJson(json['product_offer'] as Map<String, dynamic>),
    json['price'] as String,
    json['addons'] == null
        ? null
        : Addons.fromJson(json['addons'] as Map<String, dynamic>),
    json['product_image'] as String,
    json['product_desc'] as String,
    json['product_price'] as String,
    json['image'] as String,
    json['one_product_price'] as int,
    json['product_addons_price'] as String,
    json['final_price'] as String,
    json['order_pool_id'] as int,
    (json['price_with_addons'] as num)?.toDouble(),
    json['custom_meal_addons'] as String,
    json['product_calories'] as String,
    json['is_joined'] as bool,
    json['description'] as String,
  );
}

Map<String, dynamic> _$ProductInfoToJson(ProductInfo instance) =>
    <String, dynamic>{
      'product_id': instance.product_id,
      'product_name': instance.product_name,
      'image_preview': instance.image_preview,
      'product_offer': instance.product_offer,
      'price': instance.price,
      'addons': instance.addons,
      'product_image': instance.product_image,
      'product_desc': instance.product_desc,
      'product_price': instance.product_price,
      'image': instance.image,
      'one_product_price': instance.one_product_price,
      'product_addons_price': instance.product_addons_price,
      'final_price': instance.final_price,
      'order_pool_id': instance.order_pool_id,
      'price_with_addons': instance.price_with_addons,
      'custom_meal_addons': instance.custom_meal_addons,
      'product_calories': instance.product_calories,
      'is_joined': instance.is_joined,
      'description': instance.description,
    };

ProductOffer _$ProductOfferFromJson(Map<String, dynamic> json) {
  return ProductOffer(
    json['offer_id'] as int,
    json['offer_expired_at'] as String,
    json['offer_type'] as String,
    json['offer_buy_count'] as int,
    json['offer_get_count'] as int,
    (json['offer_gift_products'] as List)
        ?.map((e) => e == null
            ? null
            : OfferGiftProducts.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['offer_new_price'] as String,
  );
}

Map<String, dynamic> _$ProductOfferToJson(ProductOffer instance) =>
    <String, dynamic>{
      'offer_id': instance.offer_id,
      'offer_expired_at': instance.offer_expired_at,
      'offer_type': instance.offer_type,
      'offer_new_price': instance.offer_new_price,
      'offer_buy_count': instance.offer_buy_count,
      'offer_get_count': instance.offer_get_count,
      'offer_gift_products': instance.offer_gift_products,
    };

OfferGiftProducts _$OfferGiftProductsFromJson(Map<String, dynamic> json) {
  return OfferGiftProducts(
    json['product_id'] as int,
    json['product_name'] as String,
    json['product_image'] as String,
  );
}

Map<String, dynamic> _$OfferGiftProductsToJson(OfferGiftProducts instance) =>
    <String, dynamic>{
      'product_id': instance.product_id,
      'product_name': instance.product_name,
      'product_image': instance.product_image,
    };

Addons _$AddonsFromJson(Map<String, dynamic> json) {
  return Addons(
    (json['addon_category'] as List)
        ?.map((e) => e == null
            ? null
            : AddonCategory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['addon_id'] as int,
    json['addon_is_free'] as bool,
    (json['addon_price'] as num)?.toDouble(),
    json['addon_name'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$AddonsToJson(Addons instance) => <String, dynamic>{
      'addon_category': instance.addon_category,
      'addon_id': instance.addon_id,
      'addon_is_free': instance.addon_is_free,
      'addon_price': instance.addon_price,
      'addon_name': instance.addon_name,
      'name': instance.name,
    };

AddonCategory _$AddonCategoryFromJson(Map<String, dynamic> json) {
  return AddonCategory(
    json['cat_id'] as int,
    json['cat_name'] as String,
    json['cat_choose_type'] as String,
    (json['addons'] as List)
        ?.map((e) =>
            e == null ? null : Addons.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['cat_is_mandatory'] as bool,
    json['cat_choose_maximum'] as int,
  );
}

Map<String, dynamic> _$AddonCategoryToJson(AddonCategory instance) =>
    <String, dynamic>{
      'cat_id': instance.cat_id,
      'cat_name': instance.cat_name,
      'cat_choose_type': instance.cat_choose_type,
      'addons': instance.addons,
      'cat_is_mandatory': instance.cat_is_mandatory,
      'cat_choose_maximum': instance.cat_choose_maximum,
    };
