
import 'package:json_annotation/json_annotation.dart';
import 'package:eat_more_app/model/stauts.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse{
  StatusResponse status;
  Login data;

  LoginResponse(this.status, this.data);
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
@JsonSerializable()
class Login {
  String member_case;
  String phone;
  bool sms_sent_status;
  User member_full_info;
  String token;



  Login(this.member_case, this.phone, this.sms_sent_status,
      this.member_full_info,this.token);
  factory Login.fromJson(Map<String, dynamic> json) =>
      _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);

}

@JsonSerializable()
class User{
  int id;
  int enterprise_id;
  String phone;
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
      this.phone,
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

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class ProfileResponse{
  StatusResponse status;
  User data;

  ProfileResponse(this.status, this.data);
  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}