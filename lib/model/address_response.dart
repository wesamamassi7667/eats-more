
import 'package:eat_more_app/model/stauts.dart';
import 'package:json_annotation/json_annotation.dart';
part 'address_response.g.dart';
@JsonSerializable()
class AddressResponse{
  StatusResponse status;
  AddressData data;

  AddressResponse(this.status, this.data);
  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressResponseToJson(this);

}

@JsonSerializable()
class AddressData {
  List<Addresses> addresses;

  AddressData(this.addresses);
  factory AddressData.fromJson(Map<String, dynamic> json) =>
      _$AddressDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDataToJson(this);
}
@JsonSerializable()
class Addresses {
  int id;
  int member_id;
  int vendor_id;
  int ent_id;
  String address;
  String lat;
  String long;
  int storey_number;
  double apartment_number;
  String label;

  Addresses(
      this.id,
      this.member_id,
      this.vendor_id,
      this.ent_id,
      this.address,
      this.lat,
      this.long,
      this.storey_number,
      this.apartment_number,
      this.label);
  factory Addresses.fromJson(Map<String, dynamic> json) =>
      _$AddressesFromJson(json);

  Map<String, dynamic> toJson() => _$AddressesToJson(this);
}