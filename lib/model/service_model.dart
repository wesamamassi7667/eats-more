import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ServiceData {
  List<Services> services;

  ServiceData(this.services);
  factory ServiceData.fromJson(Map<String, dynamic> json) =>
      ServiceData(
        (json['services'] as List)
            ?.map((e) =>
        e == null ? null : Services.fromJson(e as Map<String, dynamic>))
            ?.toList(),

      );
}

@JsonSerializable()
class Services {
  int id;
  String image;
  int min_order;
  int order_time;
  String cancel_order;
  int delivery_cost;
  int time_between_orders;
  int service;
  String name;


  Services(
      this.id,
      this.image,
      this.min_order,
      this.order_time,
      this.cancel_order,
      this.delivery_cost,
      this.time_between_orders,
      this.service,
      this.name);

  factory Services.fromJson(Map<String, dynamic> json) => Services(
        json['id'] as int,
        json['image'] as String,
        json['min_order'] as int,
        json['order_time'] as int,
        json['cancel_order'] as String,
        json['delivery_cost'] as int,
        json['time_between_orders'] as int,
        json['service'] as int,
        json['name'] as String,
      );
}
