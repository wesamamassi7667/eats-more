// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : Login.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Login _$LoginFromJson(Map<String, dynamic> json) {
  return Login(
    json['member_case'] as String,
    json['phone'] as String,
    json['sms_sent_status'] as bool,
    json['member_full_info'] == null
        ? null
        : User.fromJson(json['member_full_info'] as Map<String, dynamic>),
    json['token'] as String,
  );
}

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'member_case': instance.member_case,
      'phone': instance.phone,
      'sms_sent_status': instance.sms_sent_status,
      'member_full_info': instance.member_full_info,
      'token': instance.token,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as int,
    json['enterprise_id'] as int,
    json['phone'] as String,
    json['member_image'] as String,
    json['lname'] as String,
    json['fname'] as String,
    json['last_name'] as String,
    json['avatar'] as String,
    json['gender'] as String,
    json['birthday'] as String,
    json['is_reg_active'] as int,
    json['city'] as String,
    json['nationality'] as String,
    json['email'] as String,
    json['username'] as String,
    json['fcm_token'] as String,
    json['member_id'] as int,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'enterprise_id': instance.enterprise_id,
      'phone': instance.phone,
      'member_image': instance.member_image,
      'lname': instance.lname,
      'fname': instance.fname,
      'last_name': instance.last_name,
      'avatar': instance.avatar,
      'gender': instance.gender,
      'birthday': instance.birthday,
      'is_reg_active': instance.is_reg_active,
      'city': instance.city,
      'nationality': instance.nationality,
      'email': instance.email,
      'username': instance.username,
      'fcm_token': instance.fcm_token,
      'member_id': instance.member_id,
    };

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) {
  return ProfileResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : User.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
