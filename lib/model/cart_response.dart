import 'package:eat_more_app/model/product_response.dart';
import 'package:eat_more_app/model/stauts.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_response.g.dart';
@JsonSerializable()
class CartResponse{
  StatusResponse status;
  Cart data;

  CartResponse(this.status, this.data);
  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseToJson(this);
}
@JsonSerializable()
class Cart{
 double products_price;
 int products_count;
 int order_id;
 List<ProductCart> products;

 Cart(this.products_price, this.products_count, this.order_id, this.products);
 factory Cart.fromJson(Map<String, dynamic> json) =>
     _$CartFromJson(json);

 Map<String, dynamic> toJson() => _$CartToJson(this);
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
      this.addon
      );
  factory ProductCart.fromJson(Map<String, dynamic> json) =>
      _$ProductCartFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCartToJson(this);
}

