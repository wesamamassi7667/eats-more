// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) {
  return HomeResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : Home.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Home _$HomeFromJson(Map<String, dynamic> json) {
  return Home(
    (json['slider'] as List)
        ?.map((e) =>
            e == null ? null : SliderImage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['Vendor'] as List)
        ?.map((e) =>
            e == null ? null : Restaurant.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['spes_slider'] as List)
        ?.map((e) =>
            e == null ? null : SpecSlider.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['ads'] as List)
        ?.map((e) => e == null ? null : Ads.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HomeToJson(Home instance) => <String, dynamic>{
      'slider': instance.slider,
      'Vendor': instance.Vendor,
      'spes_slider': instance.spes_slider,
      'ads': instance.ads,
    };

Ads _$AdsFromJson(Map<String, dynamic> json) {
  return Ads(
    json['image'] as String,
    json['target'] as String,
    json['display_slider_id'] as int,
    json['link'] as String,
  );
}

Map<String, dynamic> _$AdsToJson(Ads instance) => <String, dynamic>{
      'image': instance.image,
      'target': instance.target,
      'link': instance.link,
      'display_slider_id': instance.display_slider_id,
    };

SpecSlider _$SpecSliderFromJson(Map<String, dynamic> json) {
  return SpecSlider(
    json['id'] as int,
    json['sliderName'] as String,
    json['viewType'] as String,
    json['color'] as String,
    json['sort'] as int,
    (json['product'] as List)
        ?.map((e) =>
            e == null ? null : ProductHome.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SpecSliderToJson(SpecSlider instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sliderName': instance.sliderName,
      'viewType': instance.viewType,
      'color': instance.color,
      'sort': instance.sort,
      'product': instance.product,
    };

ProductHome _$ProductHomeFromJson(Map<String, dynamic> json) {
  return ProductHome(
    json['product_id'] as int,
    json['product_name'] as String,
    json['description'] as String,
    json['image'] as String,
    json['meal_price'] as String,
    json['vendor'] == null
        ? null
        : Restaurant.fromJson(json['vendor'] as Map<String, dynamic>),
    json['vendor_id'] as int,
    json['product_offer'] == null
        ? null
        : ProductOffer.fromJson(json['product_offer'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProductHomeToJson(ProductHome instance) =>
    <String, dynamic>{
      'product_id': instance.product_id,
      'product_name': instance.product_name,
      'description': instance.description,
      'image': instance.image,
      'meal_price': instance.meal_price,
      'vendor': instance.vendor,
      'vendor_id': instance.vendor_id,
      'product_offer': instance.product_offer,
    };

VendorResponse _$VendorResponseFromJson(Map<String, dynamic> json) {
  return VendorResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : Restaurant.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VendorResponseToJson(VendorResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) {
  return Restaurant(
    json['vendor_name'] as String,
    json['vendor_image'] as String,
    json['vendor_id'] as int,
    json['logo'] as String,
    json['rest_name'] as String,
    json['vendor_desc'] as String,
    json['vendor_cover_img'] as String,
    json['vendor_uuid'] as String,
    (json['delivery_cost'] as num)?.toDouble(),
    (json['delivery_time'] as num)?.toDouble(),
    json['can_pickup'] as bool,
    json['can_delivery'] as bool,
    json['wt_start_at'] as String,
    json['wt_end_at'] as String,
    (json['minimum_charge'] as num)?.toDouble(),
    json['vat_percentage'] as int,
    json['status_open'] as String,
    (json['menu_categories'] as List)
        ?.map((e) =>
            e == null ? null : MenuCategory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'vendor_name': instance.vendor_name,
      'vendor_image': instance.vendor_image,
      'vendor_id': instance.vendor_id,
      'logo': instance.logo,
      'rest_name': instance.rest_name,
      'vendor_desc': instance.vendor_desc,
      'vendor_cover_img': instance.vendor_cover_img,
      'vendor_uuid': instance.vendor_uuid,
      'delivery_cost': instance.delivery_cost,
      'delivery_time': instance.delivery_time,
      'can_pickup': instance.can_pickup,
      'can_delivery': instance.can_delivery,
      'wt_start_at': instance.wt_start_at,
      'wt_end_at': instance.wt_end_at,
      'minimum_charge': instance.minimum_charge,
      'vat_percentage': instance.vat_percentage,
      'status_open': instance.status_open,
      'menu_categories': instance.menu_categories,
    };

MenuCategory _$MenuCategoryFromJson(Map<String, dynamic> json) {
  return MenuCategory(
    json['category_id'] as int,
    json['category_name'] as String,
    json['category_image'] as String,
    json['category_sort'] as int,
    json['category_status'] as int,
  );
}

Map<String, dynamic> _$MenuCategoryToJson(MenuCategory instance) =>
    <String, dynamic>{
      'category_id': instance.category_id,
      'category_name': instance.category_name,
      'category_image': instance.category_image,
      'category_sort': instance.category_sort,
      'category_status': instance.category_status,
    };

SliderImage _$SliderImageFromJson(Map<String, dynamic> json) {
  return SliderImage(
    json['image'] as String,
  );
}

Map<String, dynamic> _$SliderImageToJson(SliderImage instance) =>
    <String, dynamic>{
      'image': instance.image,
    };

VendorCategoryResponse _$VendorCategoryResponseFromJson(
    Map<String, dynamic> json) {
  return VendorCategoryResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : VendorCategoryData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VendorCategoryResponseToJson(
        VendorCategoryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

VendorCategoryData _$VendorCategoryDataFromJson(Map<String, dynamic> json) {
  return VendorCategoryData(
    (json['vendoor_category'] as List)
        ?.map((e) => e == null
            ? null
            : VendorCategory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VendorCategoryDataToJson(VendorCategoryData instance) =>
    <String, dynamic>{
      'vendoor_category': instance.vendoor_category,
    };

VendorCategory _$VendorCategoryFromJson(Map<String, dynamic> json) {
  return VendorCategory(
    json['vendor_category_id'] as int,
    json['resturant_category_image'] as String,
    json['vendoor_category_name'] as String,
  );
}

Map<String, dynamic> _$VendorCategoryToJson(VendorCategory instance) =>
    <String, dynamic>{
      'vendor_category_id': instance.vendor_category_id,
      'resturant_category_image': instance.resturant_category_image,
      'vendoor_category_name': instance.vendoor_category_name,
    };

AllVendorResponse _$AllVendorResponseFromJson(Map<String, dynamic> json) {
  return AllVendorResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : AllVendor.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AllVendorResponseToJson(AllVendorResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

AllVendor _$AllVendorFromJson(Map<String, dynamic> json) {
  return AllVendor(
    (json['vendor'] as List)
        ?.map((e) =>
            e == null ? null : Restaurant.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AllVendorToJson(AllVendor instance) => <String, dynamic>{
      'vendor': instance.vendor,
    };
