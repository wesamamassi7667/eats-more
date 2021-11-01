import 'package:eat_more_app/model/stauts.dart';
import 'package:json_annotation/json_annotation.dart';


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
      SocialMedia(
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