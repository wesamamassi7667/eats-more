// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) {
  return OrderResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : Order.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
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

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'order_id': instance.order_id,
      'price_before_discount': instance.price_before_discount,
      'distance_in_km': instance.distance_in_km,
      'order_number': instance.order_number,
      'order_date': instance.order_date,
      'is_schedule': instance.is_schedule,
      'branch': instance.branch,
      'order_status': instance.order_status,
      'delivery_cost': instance.delivery_cost,
      'discount': instance.discount,
      'total_without_discount': instance.total_without_discount,
      'total': instance.total,
      'payment_type': instance.payment_type,
      'tip': instance.tip,
      'order_type': instance.order_type,
      'is_paid': instance.is_paid,
      'vendor_id': instance.vendor_id,
      'order_address': instance.order_address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'products': instance.products,
    };

OrderStatus _$OrderStatusFromJson(Map<String, dynamic> json) {
  return OrderStatus(
    json['id'] as int,
    json['name'] as String,
    json['desc'] as String,
  );
}

Map<String, dynamic> _$OrderStatusToJson(OrderStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
    };

Distance _$DistanceFromJson(Map<String, dynamic> json) {
  return Distance(
    json['branch_id'] as int,
    json['latitude'] as String,
    json['longitude'] as String,
    (json['distance_in_km'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$DistanceToJson(Distance instance) => <String, dynamic>{
      'branch_id': instance.branch_id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'distance_in_km': instance.distance_in_km,
    };

AllOrderResponse _$AllOrderResponseFromJson(Map<String, dynamic> json) {
  return AllOrderResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Order.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AllOrderResponseToJson(AllOrderResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

TrackOrderResponse _$TrackOrderResponseFromJson(Map<String, dynamic> json) {
  return TrackOrderResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : TrackOrder.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TrackOrderResponseToJson(TrackOrderResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

TrackOrder _$TrackOrderFromJson(Map<String, dynamic> json) {
  return TrackOrder(
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

Map<String, dynamic> _$TrackOrderToJson(TrackOrder instance) =>
    <String, dynamic>{
      'order': instance.order,
      'status': instance.status,
      'branch': instance.branch,
      'track': instance.track,
    };

Track _$TrackFromJson(Map<String, dynamic> json) {
  return Track(
    json['message'] as String,
    json['status'] as int,
    json['data'] == null
        ? null
        : TrackData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
    };

TrackData _$TrackDataFromJson(Map<String, dynamic> json) {
  return TrackData(
    (json['jobs'] as List)
        ?.map((e) => e == null ? null : Jop.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['setup'] == null
        ? null
        : Setup.fromJson(json['setup'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TrackDataToJson(TrackData instance) => <String, dynamic>{
      'jobs': instance.jobs,
      'setup': instance.setup,
    };

Setup _$SetupFromJson(Map<String, dynamic> json) {
  return Setup(
    json['map_config'] == null
        ? null
        : MapConfig.fromJson(json['map_config'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SetupToJson(Setup instance) => <String, dynamic>{
      'map_config': instance.map_config,
    };

MapConfig _$MapConfigFromJson(Map<String, dynamic> json) {
  return MapConfig(
    json['googleMap'] == null
        ? null
        : GoogleMapData.fromJson(json['googleMap'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MapConfigToJson(MapConfig instance) => <String, dynamic>{
      'googleMap': instance.googleMap,
    };

GoogleMapData _$GoogleMapDataFromJson(Map<String, dynamic> json) {
  return GoogleMapData(
    json['api_key'] as String,
  );
}

Map<String, dynamic> _$GoogleMapDataToJson(GoogleMapData instance) =>
    <String, dynamic>{
      'api_key': instance.api_key,
    };

Jop _$JopFromJson(Map<String, dynamic> json) {
  return Jop(
    json['job_id'] as int,
    json['job_latitude'] as String,
    json['job_longitude'] as String,
    json['job_type'] as int,
  );
}

Map<String, dynamic> _$JopToJson(Jop instance) => <String, dynamic>{
      'job_id': instance.job_id,
      'job_type': instance.job_type,
      'job_latitude': instance.job_latitude,
      'job_longitude': instance.job_longitude,
    };

BranchSecond _$BranchSecondFromJson(Map<String, dynamic> json) {
  return BranchSecond(
    json['branch'] == null
        ? null
        : Branch.fromJson(json['branch'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BranchSecondToJson(BranchSecond instance) =>
    <String, dynamic>{
      'branch': instance.branch,
    };

StatusOrder _$StatusOrderFromJson(Map<String, dynamic> json) {
  return StatusOrder(
    json['order_id'] as int,
    json['status_id'] as int,
    json['status_name'] as String,
    json['status_desc'] as int,
    json['status_time'] as String,
  );
}

Map<String, dynamic> _$StatusOrderToJson(StatusOrder instance) =>
    <String, dynamic>{
      'order_id': instance.order_id,
      'status_id': instance.status_id,
      'status_name': instance.status_name,
      'status_desc': instance.status_desc,
      'status_time': instance.status_time,
    };
