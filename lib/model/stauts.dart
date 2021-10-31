import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class StatusResponse{
  bool status;
  int HTTP_code;
  String HTTP_response;

  StatusResponse(this.status, this.HTTP_code, this.HTTP_response);
  factory StatusResponse.fromJson(Map<String, dynamic> json) => StatusResponse(
    json['status'] as bool,
    json['HTTP_code'] as int,
    json['HTTP_response'] as String,
  );
}