
import 'package:eat_more_app/model/product_response.dart';
import 'package:json_annotation/json_annotation.dart';



@JsonSerializable()
class FavoriteData {
  List<Favorite> favorite;

  FavoriteData(this.favorite);

  factory  FavoriteData.fromJson(Map<String, dynamic> json) =>
      FavoriteData(
        (json['favorite'] as List)
            ?.map((e) =>
        e == null ? null : Favorite.fromJson(e as Map<String, dynamic>))
            ?.toList(),
      );
}

@JsonSerializable()
class Favorite {
  ProductInfo product;
  int member_meal_favorite;

  Favorite(this.product,this.member_meal_favorite);
  factory  Favorite.fromJson(Map<String, dynamic> json) =>
      Favorite(
        json['product'] == null
            ? null
            : ProductInfo.fromJson(json['product'] as Map<String, dynamic>),
        json['member_meal_favorite'] as int,
      );
}