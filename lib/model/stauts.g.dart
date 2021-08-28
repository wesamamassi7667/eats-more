// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stauts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusResponse _$StatusResponseFromJson(Map<String, dynamic> json) {
  return StatusResponse(
    json['status'] as bool,
    json['HTTP_code'] as int,
    json['HTTP_response'] as String,
  );
}

Map<String, dynamic> _$StatusResponseToJson(StatusResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'HTTP_code': instance.HTTP_code,
      'HTTP_response': instance.HTTP_response,
    };
