import 'package:eat_more_app/model/product_response.dart';
import 'package:eat_more_app/model/stauts.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class HomeResponse{
  StatusResponse status;
  Home data;

  HomeResponse(this.status, this.data);
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      HomeResponse(
        json['status'] == null
            ? null
            : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
        json['data'] == null
            ? null
            : Home.fromJson(json['data'] as Map<String, dynamic>),
      );


}

@JsonSerializable()
class Home{
List<SliderImage> slider;
List<Restaurant> Vendor;
List<SpecSlider> spes_slider;
List<SliderImage> ads;


Home(this.slider, this.Vendor, this.spes_slider,this.ads);
factory Home.fromJson(Map<String, dynamic> json) =>Home(
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
      ?.map((e) =>
  e == null ? null : SliderImage.fromJson(e as Map<String, dynamic>))
      ?.toList(),
);

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
      SpecSlider(
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
      ProductHome(
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

@JsonSerializable()
class VendorResponse{
  StatusResponse status;
  Restaurant data;

  VendorResponse(this.status, this.data);
  factory VendorResponse.fromJson(Map<String, dynamic> json) =>
      VendorResponse(
        json['status'] == null
            ? null
            : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
        json['data'] == null
            ? null
            : Restaurant.fromJson(json['data'] as Map<String, dynamic>),
      );
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
  String VAT_NO;



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
      this.menu_categories,
      this.VAT_NO
      );

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      Restaurant(
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
        json['VAT_NO'] as String,

      );
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
      MenuCategory(
        json['category_id'] as int,
        json['category_name'] as String,
        json['category_image'] as String,
        json['category_sort'] as int,
        json['category_status'] as int,
      );
}


@JsonSerializable()
class SliderImage {
  String image;
  String target;
  String vendor;
  String product_id;
  String link;
  ProductHome product;
  int display_slider_id;

  SliderImage(this.image, this.target, this.vendor, this.product_id, this.link,this.product,this.display_slider_id);

  factory SliderImage.fromJson(Map<String, dynamic> json) =>
      SliderImage(
        json['image'] as String,
        json['target'] as String,
        json['vendor'] as String,
        json['product_id'] as String,
        json['link'] as String,
        json['product'] == null
            ? null
            : ProductHome.fromJson(json['product'] as Map<String, dynamic>),
        json['display_slider_id'] as int,
      );
}
@JsonSerializable()
class VendorCategoryResponse{
  StatusResponse status;
  VendorCategoryData data;

  VendorCategoryResponse(this.status, this.data);
  factory VendorCategoryResponse.fromJson(Map<String, dynamic> json) =>
   VendorCategoryResponse(
  json['status'] == null
  ? null
      : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
  json['data'] == null
  ? null
      : VendorCategoryData.fromJson(json['data'] as Map<String, dynamic>),
  );
}
@JsonSerializable()
class VendorCategoryData {
  List<VendorCategory> vendoor_category;

  VendorCategoryData(this.vendoor_category);
  factory VendorCategoryData.fromJson(Map<String, dynamic> json) =>
      VendorCategoryData(
        (json['vendoor_category'] as List)
            ?.map((e) => e == null
            ? null
            : VendorCategory.fromJson(e as Map<String, dynamic>))
            ?.toList(),
      );
}

@JsonSerializable()
class VendorCategory {
  int vendor_category_id;
  String resturant_category_image;
  String vendoor_category_name;

  VendorCategory(this.vendor_category_id, this.resturant_category_image,
      this.vendoor_category_name);
  factory VendorCategory.fromJson(Map<String, dynamic> json) =>
      VendorCategory(
        json['vendor_category_id'] as int,
        json['resturant_category_image'] as String,
        json['vendoor_category_name'] as String,
      );
}
@JsonSerializable()
class AllVendorResponse{
  StatusResponse status;
  AllVendor data;

  AllVendorResponse(this.status, this.data);
  factory AllVendorResponse.fromJson(Map<String, dynamic> json) =>
      AllVendorResponse(
        json['status'] == null
            ? null
            : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
        json['data'] == null
            ? null
            : AllVendor.fromJson(json['data'] as Map<String, dynamic>),
      );
}
@JsonSerializable()
class AllVendor {
  List<Restaurant> vendor;

  AllVendor(this.vendor);
  factory AllVendor.fromJson(Map<String, dynamic> json) =>
      AllVendor(
        (json['vendor'] as List)
            ?.map((e) =>
        e == null ? null : Restaurant.fromJson(e as Map<String, dynamic>))
            ?.toList(),
      );
}
