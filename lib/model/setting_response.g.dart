// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingResponse _$SettingResponseFromJson(Map<String, dynamic> json) {
  return SettingResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : Setting.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SettingResponseToJson(SettingResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Setting _$SettingFromJson(Map<String, dynamic> json) {
  return Setting(
    json['enterprise_id'] as int,
    json['gif'] as String,
    json['enterprise_vendor'] as String,
  );
}

Map<String, dynamic> _$SettingToJson(Setting instance) => <String, dynamic>{
      'enterprise_id': instance.enterprise_id,
      'gif': instance.gif,
      'enterprise_vendor': instance.vendor_image,
    };
