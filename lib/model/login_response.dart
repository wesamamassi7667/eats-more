import 'package:json_annotation/json_annotation.dart';
import 'package:eat_more_app/model/stauts.dart';

@JsonSerializable()
class User {
  int id;
  int enterprise_id;
  String member_case;
  String phone;
  bool sms_sent_status;
  User member_full_info;
  String token;
  String member_image;
  String lname;
  String fname;
  String last_name;
  String avatar;
  String gender;
  String birthday;
  int is_reg_active;
  String city;
  String nationality;
  String email;
  String username;
  String fcm_token;
  int member_id;

  User(
      this.id,
      this.enterprise_id,
      this.member_case,
      this.phone,
      this.sms_sent_status,
      this.member_full_info,
      this.token,
      this.member_image,
      this.lname,
      this.fname,
      this.last_name,
      this.avatar,
      this.gender,
      this.birthday,
      this.is_reg_active,
      this.city,
      this.nationality,
      this.email,
      this.username,
      this.fcm_token,
      this.member_id);

  factory User.fromJson(Map<String, dynamic> json) => User(
        json['id'] as int,
        json['enterprise_id'] as int,
        json['member_case'] as String,
        json['phone'] as String,
        json['sms_sent_status'] as bool,
        json['member_full_info'] == null
            ? null
            : User.fromJson(json['member_full_info'] as Map<String, dynamic>),
        json['token'] as String,
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

  Map<String, dynamic> $UserToJson(User instance) => <String, dynamic>{
        'id': instance.id,
        'enterprise_id': instance.enterprise_id,
        'member_case': instance.member_case,
        'phone': instance.phone,
        'sms_sent_status': instance.sms_sent_status,
        'member_full_info': instance.member_full_info,
        'token': instance.token,
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
}

@JsonSerializable()
class ProfileResponse {
  StatusResponse status;
  User data;

  ProfileResponse(this.status, this.data);

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        json['status'] == null
            ? null
            : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
        json['data'] == null
            ? null
            : User.fromJson(json['data'] as Map<String, dynamic>),
      );
}
