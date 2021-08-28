
import 'package:eat_more_app/model/stauts.dart';
import 'package:json_annotation/json_annotation.dart';
part 'branch_response.g.dart';

@JsonSerializable()
class BranchResponse{
StatusResponse status;
BranchData data;

BranchResponse(this.status, this.data);
factory BranchResponse.fromJson(Map<String, dynamic> json) =>
    _$BranchResponseFromJson(json);

Map<String, dynamic> toJson() => _$BranchResponseToJson(this);
}


@JsonSerializable()
class BranchData{
  List<Branch> branches;

  BranchData(this.branches);
  factory BranchData.fromJson(Map<String, dynamic> json) =>
      _$BranchDataFromJson(json);

  Map<String, dynamic> toJson() => _$BranchDataToJson(this);
}
@JsonSerializable()
class Branch {
  int branch_id;
  String branch_name;
  double max_area_delivery;
  double phone_code;
  String longitude;
  String latitude;
  String distance;
  String distance_type;
  String branch_address;
  String branch_lat;
  String branch_long;


  Branch(
      this.branch_id,
      this.branch_name,
      this.max_area_delivery,
      this.phone_code,
      this.longitude,
      this.latitude,
      this.distance,
      this.distance_type,
      this.branch_address,
      this.branch_lat,
      this.branch_long);

  factory Branch.fromJson(Map<String, dynamic> json) =>
      _$BranchFromJson(json);

  Map<String, dynamic> toJson() => _$BranchToJson(this);

}