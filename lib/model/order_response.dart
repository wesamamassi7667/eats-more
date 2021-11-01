import 'package:eat_more_app/model/branch_response.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:eat_more_app/model/stauts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'cart_response.dart';


@JsonSerializable()
class Order {
  int orderId;
  double price_before_discount;
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
      this.orderId,
      this.price_before_discount,
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

  factory Order.fromJson(Map<String, dynamic> json) =>Order(
    json['order_id'] as int,
    (json['price_before_discount'] as num)?.toDouble(),
    (json['distance_in_km'] as List)
        ?.map((e) =>
    e == null ? null : Distance.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['order_number'] as String,
    json['order_date'] as String,
    json['is_schedule'] as bool,
    json['branch'] == null
        ? null
        : Branch.fromJson(json['branch'] as Map<String, dynamic>),
    json['order_status'] == null
        ? null
        : OrderStatus.fromJson(json['order_status'] as Map<String, dynamic>),
    (json['delivery_cost'] as num)?.toDouble(),
    (json['discount'] as num)?.toDouble(),
    (json['total_without_discount'] as num)?.toDouble(),
    (json['total'] as num)?.toDouble(),
    json['payment_type'] as String,
    json['tip'] as String,
    json['order_type'] as String,
    json['is_paid'] as bool,
    json['vendor_id'] as int,
    json['order_address'] as String,
    json['latitude'] as String,
    json['longitude'] as String,
    (json['products'] as List)
        ?.map((e) =>
    e == null ? null : ProductCart.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );

}

@JsonSerializable()
class OrderStatus {
  int id;
  String name;
  String desc;

  OrderStatus(this.id, this.name, this.desc);
  factory OrderStatus.fromJson(Map<String, dynamic> json) =>
      OrderStatus(
        json['id'] as int,
        json['name'] as String,
        json['desc'] as String,
      );
}


@JsonSerializable()
class Distance {
  int branch_id;
  String latitude;
  String longitude;
  double distance_in_km;

  Distance(this.branch_id, this.latitude, this.longitude, this.distance_in_km);
  factory Distance.fromJson(Map<String, dynamic> json) =>
      Distance(
        json['branch_id'] as int,
        json['latitude'] as String,
        json['longitude'] as String,
        (json['distance_in_km'] as num)?.toDouble(),
      );
}

@JsonSerializable()
class TrackOrder {
  Order order;
  List<StatusOrder> status;
  BranchSecond branch;
  Track track;
  TrackOrder(this.order, this.status,this.branch,this.track);
  factory TrackOrder.fromJson(Map<String, dynamic> json) =>
      TrackOrder(
        json['order'] == null
            ? null
            : Order.fromJson(json['order'] as Map<String, dynamic>),
        (json['status'] as List)
            ?.map((e) =>
        e == null ? null : StatusOrder.fromJson(e as Map<String, dynamic>))
            ?.toList(),
        json['branch'] == null
            ? null
            : BranchSecond.fromJson(json['branch'] as Map<String, dynamic>),
        json['track'] == null
            ? null
            : Track.fromJson(json['track'] as Map<String, dynamic>),
      );

}
@JsonSerializable()
class Track {
 String message;
 int status;
 TrackData data;

 Track(this.message, this.status, this.data);
 factory Track.fromJson(Map<String, dynamic> json) =>
     Track(
       json['message'] as String,
       json['status'] as int,
       json['data'] == null
           ? null
           : TrackData.fromJson(json['data'] as Map<String, dynamic>),
     );
}
@JsonSerializable()
class TrackData {
  List<Jop> jobs;
  Setup setup;

  TrackData(this.jobs,this.setup);
  factory TrackData.fromJson(Map<String, dynamic> json) =>
      TrackData(
        (json['jobs'] as List)
            ?.map((e) => e == null ? null : Jop.fromJson(e as Map<String, dynamic>))
            ?.toList(),
        json['setup'] == null
            ? null
            : Setup.fromJson(json['setup'] as Map<String, dynamic>),
      );
}
@JsonSerializable()
class Setup {
  MapConfig map_config;
  Setup(this.map_config);
  factory Setup.fromJson(Map<String, dynamic> json) =>
      Setup(
        json['map_config'] == null
            ? null
            : MapConfig.fromJson(json['map_config'] as Map<String, dynamic>),
      );
}
@JsonSerializable()
class MapConfig {
 GoogleMapData googleMap;
 MapConfig(this.googleMap);
 factory MapConfig.fromJson(Map<String, dynamic> json) =>
     MapConfig(
       json['googleMap'] == null
           ? null
           : GoogleMapData.fromJson(json['googleMap'] as Map<String, dynamic>),
     );
}
@JsonSerializable()
class GoogleMapData {
  String api_key;
  GoogleMapData(this.api_key);
  factory GoogleMapData.fromJson(Map<String, dynamic> json) =>
      GoogleMapData(
        json['api_key'] as String,
      );
}
@JsonSerializable()
class Jop {
  int job_id;
  int job_type;
  String job_latitude;
  String job_longitude;

  Jop(this.job_id, this.job_latitude, this.job_longitude,this.job_type);
  factory Jop.fromJson(Map<String, dynamic> json) =>
      Jop(
        json['job_id'] as int,
        json['job_latitude'] as String,
        json['job_longitude'] as String,
        json['job_type'] as int,
      );
}

@JsonSerializable()
class BranchSecond {
  Branch branch;
  BranchSecond(this.branch);
  factory BranchSecond.fromJson(Map<String, dynamic> json) =>
      BranchSecond(
        json['branch'] == null
            ? null
            : Branch.fromJson(json['branch'] as Map<String, dynamic>),
      );
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
      StatusOrder(
        json['order_id'] as int,
        json['status_id'] as int,
        json['status_name'] as String,
        json['status_desc'] as int,
        json['status_time'] as String,
      );
}


