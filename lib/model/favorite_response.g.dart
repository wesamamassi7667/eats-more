// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteResponse _$FavoriteResponseFromJson(Map<String, dynamic> json) {
  return FavoriteResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
  )..data = json['data'] == null
      ? null
      : FavoriteData.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$FavoriteResponseToJson(FavoriteResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

FavoriteData _$FavoriteDataFromJson(Map<String, dynamic> json) {
  return FavoriteData(
    (json['favorite'] as List)
        ?.map((e) =>
            e == null ? null : Favorite.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FavoriteDataToJson(FavoriteData instance) =>
    <String, dynamic>{
      'favorite': instance.favorite,
    };

Favorite _$FavoriteFromJson(Map<String, dynamic> json) {
  return Favorite(
    json['product'] == null
        ? null
        : ProductInfo.fromJson(json['product'] as Map<String, dynamic>),
    json['member_meal_favorite'] as int,
  );
}

Map<String, dynamic> _$FavoriteToJson(Favorite instance) => <String, dynamic>{
      'product': instance.product,
      'member_meal_favorite': instance.member_meal_favorite,
    };
