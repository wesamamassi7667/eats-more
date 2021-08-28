import 'package:eat_more_app/model/product_response.dart';
import 'package:eat_more_app/model/stauts.dart';
import 'package:json_annotation/json_annotation.dart';
part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse{
  StatusResponse status;
  Home data;

  HomeResponse(this.status, this.data);
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}

@JsonSerializable()
class Home{
List<SliderImage> slider;
List<Restaurant> Vendor;
List<SpecSlider> spes_slider;
List<Ads> ads;

Home(this.slider, this.Vendor, this.spes_slider,this.ads);
factory Home.fromJson(Map<String, dynamic> json) =>
    _$HomeFromJson(json);

Map<String, dynamic> toJson() => _$HomeToJson(this);
}
@JsonSerializable()
class Ads{
String image;
String target;
String link;
int display_slider_id;

Ads(this.image, this.target, this.display_slider_id,this.link);
factory Ads.fromJson(Map<String, dynamic> json) =>
    _$AdsFromJson(json);

Map<String, dynamic> toJson() => _$AdsToJson(this);

}
@JsonSerializable()
class SpecSlider {
  int id;
  String sliderName;
  String viewType;
  String color;
  int sort;
  List<ProductHome> product;

  SpecSlider(this.id, this.sliderName, this.viewType, this.color, this.sort,
      this.product);
  factory SpecSlider.fromJson(Map<String, dynamic> json) =>
      _$SpecSliderFromJson(json);

  Map<String, dynamic> toJson() => _$SpecSliderToJson(this);
}
@JsonSerializable()
class ProductHome{
  int product_id;
  String product_name;
  String description;
  String image;
  String meal_price;
  Restaurant vendor;
  int vendor_id;
  ProductOffer product_offer;



  ProductHome(this.product_id, this.product_name, this.description, this.image,
      this.meal_price,this.vendor,this.vendor_id,this.product_offer);
  factory ProductHome.fromJson(Map<String, dynamic> json) =>
      _$ProductHomeFromJson(json);

  Map<String, dynamic> toJson() => _$ProductHomeToJson(this);
}

@JsonSerializable()
class VendorResponse{
  StatusResponse status;
  Restaurant data;

  VendorResponse(this.status, this.data);
  factory VendorResponse.fromJson(Map<String, dynamic> json) =>
      _$VendorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VendorResponseToJson(this);
}
@JsonSerializable()
class Restaurant {
  String vendor_name;
  String vendor_image;
  int vendor_id;
  String logo;
  String rest_name;
  String vendor_desc;
  String vendor_cover_img;
  String vendor_uuid;
  double delivery_cost;
  double delivery_time;
  bool can_pickup;
  bool can_delivery;
  String wt_start_at;
  String wt_end_at;
  double minimum_charge;
  int vat_percentage;
  String status_open;
  List<MenuCategory> menu_categories;


  Restaurant(
      this.vendor_name,
      this.vendor_image,
      this.vendor_id,
      this.logo,
      this.rest_name,
      this.vendor_desc,
      this.vendor_cover_img,
      this.vendor_uuid,
      this.delivery_cost,
      this.delivery_time,
      this.can_pickup,
      this.can_delivery,
      this.wt_start_at,
      this.wt_end_at,
      this.minimum_charge,
      this.vat_percentage,
      this.status_open,
      this.menu_categories);

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}
@JsonSerializable()
class MenuCategory {
  int category_id;
  String category_name;
  String category_image;
  int category_sort;
  int category_status;

  MenuCategory(this.category_id, this.category_name, this.category_image,
      this.category_sort, this.category_status);
  factory MenuCategory.fromJson(Map<String, dynamic> json) =>
      _$MenuCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$MenuCategoryToJson(this);
}


@JsonSerializable()
class SliderImage {
  String image;

  SliderImage(this.image);
  factory SliderImage.fromJson(Map<String, dynamic> json) =>
      _$SliderImageFromJson(json);

  Map<String, dynamic> toJson() => _$SliderImageToJson(this);
}
@JsonSerializable()
class VendorCategoryResponse{
  StatusResponse status;
  VendorCategoryData data;

  VendorCategoryResponse(this.status, this.data);
  factory VendorCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$VendorCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VendorCategoryResponseToJson(this);
}
@JsonSerializable()
class VendorCategoryData {
  List<VendorCategory> vendoor_category;

  VendorCategoryData(this.vendoor_category);
  factory VendorCategoryData.fromJson(Map<String, dynamic> json) =>
      _$VendorCategoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$VendorCategoryDataToJson(this);
}

@JsonSerializable()
class VendorCategory {
  int vendor_category_id;
  String resturant_category_image;
  String vendoor_category_name;

  VendorCategory(this.vendor_category_id, this.resturant_category_image,
      this.vendoor_category_name);
  factory VendorCategory.fromJson(Map<String, dynamic> json) =>
      _$VendorCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$VendorCategoryToJson(this);
}
@JsonSerializable()
class AllVendorResponse{
  StatusResponse status;
  AllVendor data;

  AllVendorResponse(this.status, this.data);
  factory AllVendorResponse.fromJson(Map<String, dynamic> json) =>
      _$AllVendorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllVendorResponseToJson(this);
}
@JsonSerializable()
class AllVendor {
  List<Restaurant> vendor;

  AllVendor(this.vendor);
  factory AllVendor.fromJson(Map<String, dynamic> json) =>
      _$AllVendorFromJson(json);

  Map<String, dynamic> toJson() => _$AllVendorToJson(this);
}
