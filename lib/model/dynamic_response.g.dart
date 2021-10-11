// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicResponse _$DynamicResponseFromJson(Map<String, dynamic> json) {
  return DynamicResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'],
  );
}

Map<String, dynamic> _$DynamicResponseToJson(DynamicResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
