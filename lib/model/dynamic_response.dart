
import 'package:eat_more_app/model/stauts.dart';
import 'package:json_annotation/json_annotation.dart';
part 'dynamic_response.g.dart';

@JsonSerializable()
class DynamicResponse{
  StatusResponse status;
  dynamic data;


  DynamicResponse(this.status, this.data);

  factory DynamicResponse.fromJson(Map<String, dynamic> json) =>
      _$DynamicResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DynamicResponseToJson(this);
}