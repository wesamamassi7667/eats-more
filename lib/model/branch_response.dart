
import 'package:eat_more_app/model/stauts.dart';
import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class BranchData{
  List<Branch> branches;

  BranchData(this.branches);
  factory BranchData.fromJson(Map<String, dynamic> json) =>
      BranchData(
        (json['branches'] as List)
            ?.map((e) =>
        e == null ? null : Branch.fromJson(e as Map<String, dynamic>))
            ?.toList(),

      );


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
      Branch(
        json['branch_id'] as int,
        json['branch_name'] as String,
        (json['max_area_delivery'] as num)?.toDouble(),
        (json['phone_code'] as num)?.toDouble(),
        json['longitude'] as String,
        json['latitude'] as String,
        json['distance'] as String,
        json['distance_type'] as String,
        json['branch_address'] as String,
        json['branch_lat'] as String,
        json['branch_long'] as String,
      );
}

