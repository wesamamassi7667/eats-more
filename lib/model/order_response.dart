import 'package:eat_more_app/model/branch_response.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:eat_more_app/model/stauts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'cart_response.dart';
part 'order_response.g.dart';

@JsonSerializable()
class OrderResponse{
  StatusResponse status;
  Order data;

  OrderResponse(this.status, this.data);
  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}
@JsonSerializable()
class Order {
  int order_id;
  double price_before_discount;
  // String price_after_discount;
  List<Distance> distance_in_km;
  String order_number;
  String order_date;
  bool is_schedule;
  Branch branch;
  OrderStatus order_status;
  double delivery_cost;
  double discount;
  double total_without_discount;
  double total;
  String payment_type;
  String tip;
  String order_type;
  bool is_paid;
  int vendor_id;
  String order_address;
  String latitude;
  String longitude;
  List<ProductCart> products;
  Order(
      this.order_id,
      this.price_before_discount,
      // this.price_after_discount,
      this.distance_in_km,
      this.order_number,
      this.order_date,
      this.is_schedule,
      this.branch,
      this.order_status,
      this.delivery_cost,
      this.discount,
      this.total_without_discount,
      this.total,
      this.payment_type,
      this.tip,
      this.order_type,
      this.is_paid,
      this.vendor_id,
      this.order_address,
      this.latitude,
      this.longitude,
      this.products);

  factory Order.fromJson(Map<String, dynamic> json) =>
      _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
@JsonSerializable()
class OrderStatus {
  int id;
  String name;
  String desc;

  OrderStatus(this.id, this.name, this.desc);
  factory OrderStatus.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusToJson(this);
}
@JsonSerializable()
class Distance {
  int branch_id;
  String latitude;
  String longitude;
  double distance_in_km;

  Distance(this.branch_id, this.latitude, this.longitude, this.distance_in_km);
  factory Distance.fromJson(Map<String, dynamic> json) =>
      _$DistanceFromJson(json);

  Map<String, dynamic> toJson() => _$DistanceToJson(this);
}

@JsonSerializable()
class AllOrderResponse{
  StatusResponse status;
  List<Order> data;
  AllOrderResponse(this.status, this.data);
  factory AllOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$AllOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllOrderResponseToJson(this);
}

@JsonSerializable()
class TrackOrderResponse{
  StatusResponse status;
  TrackOrder data;

  TrackOrderResponse(this.status, this.data);
  factory TrackOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$TrackOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrackOrderResponseToJson(this);

}
@JsonSerializable()
class TrackOrder {
  Order order;
  List<StatusOrder> status;
  BranchSecond branch;
  Track track;
  TrackOrder(this.order, this.status,this.branch,this.track);
  factory TrackOrder.fromJson(Map<String, dynamic> json) =>
      _$TrackOrderFromJson(json);

  Map<String, dynamic> toJson() => _$TrackOrderToJson(this);

}
@JsonSerializable()
class Track {
 String message;
 int status;
 TrackData data;

 Track(this.message, this.status, this.data);
 factory Track.fromJson(Map<String, dynamic> json) =>
     _$TrackFromJson(json);

 Map<String, dynamic> toJson() => _$TrackToJson(this);
}
@JsonSerializable()
class TrackData {
  List<Jop> jobs;
  Setup setup;

  TrackData(this.jobs,this.setup);
  factory TrackData.fromJson(Map<String, dynamic> json) =>
      _$TrackDataFromJson(json);

  Map<String, dynamic> toJson() => _$TrackDataToJson(this);
}
@JsonSerializable()
class Setup {
  MapConfig map_config;
  Setup(this.map_config);
  factory Setup.fromJson(Map<String, dynamic> json) =>
      _$SetupFromJson(json);

  Map<String, dynamic> toJson() => _$SetupToJson(this);
}
@JsonSerializable()
class MapConfig {
 GoogleMapData googleMap;
 MapConfig(this.googleMap);
 factory MapConfig.fromJson(Map<String, dynamic> json) =>
     _$MapConfigFromJson(json);

 Map<String, dynamic> toJson() => _$MapConfigToJson(this);
}
@JsonSerializable()
class GoogleMapData {
  String api_key;
  GoogleMapData(this.api_key);
  factory GoogleMapData.fromJson(Map<String, dynamic> json) =>
      _$GoogleMapDataFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleMapDataToJson(this);
}
@JsonSerializable()
class Jop {
  int job_id;
  int job_type;
  String job_latitude;
  String job_longitude;

  Jop(this.job_id, this.job_latitude, this.job_longitude,this.job_type);
  factory Jop.fromJson(Map<String, dynamic> json) =>
      _$JopFromJson(json);

  Map<String, dynamic> toJson() => _$JopToJson(this);
}

@JsonSerializable()
class BranchSecond {
  Branch branch;
  BranchSecond(this.branch);
  factory BranchSecond.fromJson(Map<String, dynamic> json) =>
      _$BranchSecondFromJson(json);

  Map<String, dynamic> toJson() => _$BranchSecondToJson(this);
}
@JsonSerializable()
class StatusOrder {
  int order_id;
  int status_id;
  String status_name ;
  int status_desc;
  String status_time;

  StatusOrder(
      this.order_id, this.status_id, this.status_name, this.status_desc,this.status_time);
  factory StatusOrder.fromJson(Map<String, dynamic> json) =>
      _$StatusOrderFromJson(json);

  Map<String, dynamic> toJson() => _$StatusOrderToJson(this);
}


