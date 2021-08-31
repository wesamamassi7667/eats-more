import 'package:eat_more_app/model/stauts.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myfatoorah_flutter/model/executepayment/MFExecutePaymentRequest.dart';
import 'package:myfatoorah_flutter/model/paymentstatus/SDKPaymentStatusResponse.dart';
part 'my_myfatoorah_response.g.dart';

@JsonSerializable()
class MyFatoorahResponse{
  StatusResponse status;
  MyFatoorah data;


  MyFatoorahResponse(this.status, this.data);
  factory MyFatoorahResponse.fromJson(Map<String, dynamic> json) =>
      _$MyFatoorahResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyFatoorahResponseToJson(this);
}
@JsonSerializable()
class MyFatoorah {
  String base_url;
  String token;

  MyFatoorah(this.base_url, this.token);
  factory MyFatoorah.fromJson(Map<String, dynamic> json) =>
      _$MyFatoorahFromJson(json);

  Map<String, dynamic> toJson() => _$MyFatoorahToJson(this);

}
@JsonSerializable()
class MyFatoorahPaymentResponse{
  StatusResponse status;
  MyFatoorahPayment data;

  MyFatoorahPaymentResponse(this.status, this.data);
  factory MyFatoorahPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$MyFatoorahPaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyFatoorahPaymentResponseToJson(this);
}
@JsonSerializable()
class MyFatoorahPayment {
  String NotificationOption;
  String CustomerName;
  String DisplayCurrencyIso;
  String MobileCountryCode;
  String CustomerMobile;
  String CustomerEmail;
  double InvoiceValue;
  String Language;
  int CustomerReference;
  String UserDefinedField;
  String ApiCustomFileds;
  String API_Token;
  List<InvoiceItem> InvoiceItems;
  String API_URL;
  List<Supplier> Suppliers;


  MyFatoorahPayment(
      this.NotificationOption,
      this.CustomerName,
      this.DisplayCurrencyIso,
      this.MobileCountryCode,
      this.CustomerMobile,
      this.CustomerEmail,
      this.InvoiceValue,
      this.Language,

      this.CustomerReference,
      this.UserDefinedField,
      this.ApiCustomFileds,
      this.API_Token,
      this.InvoiceItems,
      this.API_URL,
      this.Suppliers
      );

  factory MyFatoorahPayment.fromJson(Map<String, dynamic> json) =>
      _$MyFatoorahPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$MyFatoorahPaymentToJson(this);
}









