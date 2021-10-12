
import 'package:eat_more_app/model/product_response.dart';
import 'package:eat_more_app/model/stauts.dart';
import 'package:json_annotation/json_annotation.dart';
part 'favorite_response.g.dart';

@JsonSerializable()
class FavoriteResponse{
  StatusResponse status;
  FavoriteData data;

  FavoriteResponse(this.status);
  factory  FavoriteResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteResponseToJson(this);
}

@JsonSerializable()
class FavoriteData {
  List<Favorite> favorite;

  FavoriteData(this.favorite);

  factory  FavoriteData.fromJson(Map<String, dynamic> json) =>
      _$FavoriteDataFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteDataToJson(this);
}

@JsonSerializable()
class Favorite {
  ProductInfo product;
  int member_meal_favorite;

  Favorite(this.product,this.member_meal_favorite);
  factory  Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteToJson(this);
}