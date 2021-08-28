// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressResponse _$AddressResponseFromJson(Map<String, dynamic> json) {
  return AddressResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : AddressData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AddressResponseToJson(AddressResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

AddressData _$AddressDataFromJson(Map<String, dynamic> json) {
  return AddressData(
    (json['addresses'] as List)
        ?.map((e) =>
            e == null ? null : Addresses.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AddressDataToJson(AddressData instance) =>
    <String, dynamic>{
      'addresses': instance.addresses,
    };

Addresses _$AddressesFromJson(Map<String, dynamic> json) {
  return Addresses(
    json['id'] as int,
    json['member_id'] as int,
    json['vendor_id'] as int,
    json['ent_id'] as int,
    json['address'] as String,
    json['lat'] as String,
    json['long'] as String,
    json['storey_number'] as int,
    (json['apartment_number'] as num)?.toDouble(),
    json['label'] as String,
  );
}

Map<String, dynamic> _$AddressesToJson(Addresses instance) => <String, dynamic>{
      'id': instance.id,
      'member_id': instance.member_id,
      'vendor_id': instance.vendor_id,
      'ent_id': instance.ent_id,
      'address': instance.address,
      'lat': instance.lat,
      'long': instance.long,
      'storey_number': instance.storey_number,
      'apartment_number': instance.apartment_number,
      'label': instance.label,
    };
