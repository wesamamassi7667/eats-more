import 'package:eat_more_app/model/product_response.dart';
import 'package:eat_more_app/model/stauts.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Cart{
 double products_price;
 int products_count;
 int order_id;
 List<ProductCart> products;

 Cart(this.products_price, this.products_count, this.order_id, this.products);
 factory Cart.fromJson(Map<String, dynamic> json) =>
     Cart(
       (json['products_price'] as num)?.toDouble(),
       json['products_count'] as int,
       json['order_id'] as int,
       (json['products'] as List)
           ?.map((e) =>
       e == null ? null : ProductCart.fromJson(e as Map<String, dynamic>))
           ?.toList(),
     );
}
@JsonSerializable()
class ProductCart {
  int basket_product_id;
  String custom_addons;
  int product_id;
  String product_name;
  String product_image;
  int quantity;
  double one_product_price;
  String product_addons_price;
  String final_price;
  ProductOffer product_offer;
  List<Addons> addons;
  String image;
  String product_desc;
  List<Addons> addon;


  ProductCart(
      this.basket_product_id,
      this.custom_addons,
      this.product_id,
      this.product_name,
      this.product_image,
      this.quantity,
      this.one_product_price,
      this.product_addons_price,
      this.final_price,
      this.product_offer,
      this.addons,
      this.image,
      this.product_desc,
      this.addon
      );
  factory ProductCart.fromJson(Map<String, dynamic> json) =>
      ProductCart(
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
        json['description'] as String,
        (json['addon'] as List)
            ?.map((e) =>
        e == null ? null : Addons.fromJson(e as Map<String, dynamic>))
            ?.toList(),
      );
}

