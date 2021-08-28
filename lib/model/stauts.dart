import 'package:json_annotation/json_annotation.dart';
part 'stauts.g.dart';

@JsonSerializable()
class StatusResponse{
  bool status;
  int HTTP_code;
  String HTTP_response;

  StatusResponse(this.status, this.HTTP_code, this.HTTP_response);
  factory StatusResponse.fromJson(Map<String, dynamic> json) =>
      _$StatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StatusResponseToJson(this);
}