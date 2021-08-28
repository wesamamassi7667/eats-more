// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactResponse _$ContactResponseFromJson(Map<String, dynamic> json) {
  return ContactResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : SocialMedia.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ContactResponseToJson(ContactResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

SocialMedia _$SocialMediaFromJson(Map<String, dynamic> json) {
  return SocialMedia(
    json['facebook'] as String,
    json['twitter'] as String,
    json['whatsapp'] as String,
    json['phone'] as String,
    json['website'] as String,
    json['instagram'] as String,
    json['snapchat'] as String,
    json['youtube'] as String,
  );
}

Map<String, dynamic> _$SocialMediaToJson(SocialMedia instance) =>
    <String, dynamic>{
      'facebook': instance.facebook,
      'twitter': instance.twitter,
      'whatsapp': instance.whatsapp,
      'phone': instance.phone,
      'website': instance.website,
      'instagram': instance.instagram,
      'snapchat': instance.snapchat,
      'youtube': instance.youtube,
    };
