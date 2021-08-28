
import 'package:eat_more_app/model/stauts.dart';
import 'package:json_annotation/json_annotation.dart';
part 'setting_response.g.dart';

@JsonSerializable()
class SettingResponse{
  StatusResponse status;
  Setting data;

  SettingResponse(this.status, this.data);
  factory SettingResponse .fromJson(Map<String, dynamic> json) =>
      _$SettingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SettingResponseToJson(this);
}
@JsonSerializable()
class Setting {
  int enterprise_id;
  String gif;
  String enterprise_image;

  Setting(this.enterprise_id, this.gif,this.enterprise_image);

  factory Setting .fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);
}

