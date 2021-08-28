// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchResponse _$BranchResponseFromJson(Map<String, dynamic> json) {
  return BranchResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : BranchData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BranchResponseToJson(BranchResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

BranchData _$BranchDataFromJson(Map<String, dynamic> json) {
  return BranchData(
    (json['branches'] as List)
        ?.map((e) =>
            e == null ? null : Branch.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BranchDataToJson(BranchData instance) =>
    <String, dynamic>{
      'branches': instance.branches,
    };

Branch _$BranchFromJson(Map<String, dynamic> json) {
  return Branch(
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

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
      'branch_id': instance.branch_id,
      'branch_name': instance.branch_name,
      'max_area_delivery': instance.max_area_delivery,
      'phone_code': instance.phone_code,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'distance': instance.distance,
      'distance_type': instance.distance_type,
      'branch_address': instance.branch_address,
      'branch_lat': instance.branch_lat,
      'branch_long': instance.branch_long,
    };
