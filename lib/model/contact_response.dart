import 'package:eat_more_app/model/stauts.dart';
import 'package:json_annotation/json_annotation.dart';
part 'contact_response.g.dart';

@JsonSerializable()
class ContactResponse{
  StatusResponse status;
  SocialMedia data;

  ContactResponse(this.status, this.data);
  factory ContactResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContactResponseToJson(this);

}
@JsonSerializable()
class SocialMedia {
  String facebook;
  String twitter;
  String whatsapp;
  String phone;
  String website;
  String instagram;
  String snapchat;
  String youtube;

  SocialMedia(this.facebook, this.twitter, this.whatsapp, this.phone,
      this.website, this.instagram, this.snapchat, this.youtube);
  factory SocialMedia.fromJson(Map<String, dynamic> json) =>
      _$SocialMediaFromJson(json);

  Map<String, dynamic> toJson() => _$SocialMediaToJson(this);
}