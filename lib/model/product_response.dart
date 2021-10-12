import 'package:eat_more_app/model/stauts.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_response.g.dart';
@JsonSerializable()
class ProductResponse {
  StatusResponse status;
  Product data;

  ProductResponse(this.status, this.data);

  factory ProductResponse .fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}
@JsonSerializable()
class MenuResponse {
  StatusResponse status;
  Menu data;
  MenuResponse(this.status, this.data);
  factory MenuResponse.fromJson(Map<String, dynamic> json) =>
      _$MenuResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MenuResponseToJson(this);
}
@JsonSerializable()
class Menu {
  List<ProductInfo> products_menu;

  Menu(this.products_menu);
  factory Menu.fromJson(Map<String, dynamic> json) =>
      _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);
}

@JsonSerializable()
class Product {
  ProductInfo product_info;

  Product(this.product_info);
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class ProductInfo {
  int product_id;
  String product_name;
  String image_preview;
  ProductOffer product_offer;
  String price;
  Addons addons;
  String product_image;
  String product_desc;
  String product_price;
  String image;
  int one_product_price;
  String product_addons_price;
  String final_price;
  int order_pool_id;
  double price_with_addons;
  String custom_meal_addons;
  String product_calories;
  bool is_joined;
  String description;


  ProductInfo(
      this.product_id,
      this.product_name,
      this.image_preview,
      this.product_offer,
      this.price,
      this.addons,
      this.product_image,
      this.product_desc,
      this.product_price,
      this.image,
      this.one_product_price,
      this.product_addons_price,
      this.final_price,
      this.order_pool_id,
      this.price_with_addons,
      this.custom_meal_addons,
      this.product_calories,
      this.is_joined,
      this.description
      );

  factory ProductInfo.fromJson(Map<String, dynamic> json) =>
      _$ProductInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductInfoToJson(this);
}

@JsonSerializable()
class ProductOffer {
int offer_id;
String offer_expired_at;
String offer_type;
String offer_new_price;
int offer_buy_count;
int offer_get_count;
List<OfferGiftProducts> offer_gift_products;


ProductOffer(this.offer_id, this.offer_expired_at, this.offer_type,
      this.offer_buy_count, this.offer_get_count, this.offer_gift_products,this.offer_new_price);

  factory ProductOffer.fromJson(Map<String, dynamic> json) =>
    _$ProductOfferFromJson(json);

Map<String, dynamic> toJson() => _$ProductOfferToJson(this);
}
@JsonSerializable()
class OfferGiftProducts{
  int product_id;
  String product_name;
  String product_image;

  OfferGiftProducts(this.product_id, this.product_name, this.product_image);

  factory OfferGiftProducts.fromJson(Map<String, dynamic> json) =>
      _$OfferGiftProductsFromJson(json);

  Map<String, dynamic> toJson() => _$OfferGiftProductsToJson(this);
}
@JsonSerializable()
class Addons{
  List<AddonCategory> addon_category;
  int addon_id;
  bool addon_is_free;
  double addon_price;
  String addon_name;
  String name;


  Addons(this.addon_category, this.addon_id, this.addon_is_free,
      this.addon_price, this.addon_name,this.name);

  factory Addons.fromJson(Map<String, dynamic> json) =>
      _$AddonsFromJson(json);

  Map<String, dynamic> toJson() => _$AddonsToJson(this);
}
@JsonSerializable()
class AddonCategory {
  int cat_id;
  String cat_name;
  String cat_choose_type;
  List<Addons> addons;
  bool cat_is_mandatory;
  int cat_choose_maximum;

  AddonCategory(this.cat_id, this.cat_name, this.cat_choose_type, this.addons,this.cat_is_mandatory,this.cat_choose_maximum);

  factory AddonCategory.fromJson(Map<String, dynamic> json) =>
      _$AddonCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$AddonCategoryToJson(this);
}

