import 'package:eat_more_app/model/stauts.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myfatoorah_flutter/model/executepayment/MFExecutePaymentRequest.dart';


@JsonSerializable()
class MyFatoorah {
  String base_url;
  String token;

  MyFatoorah(this.base_url, this.token);
  factory MyFatoorah.fromJson(Map<String, dynamic> json) =>
      MyFatoorah(
        json['base_url'] as String,
        json['token'] as String,
      );

}

@JsonSerializable()
class MyFatoorahPayment {
  String NotificationOption;
  String CustomerName;
  String DisplayCurrencyIso;
  String MobileCountryCode;
  String CustomerMobile;
  String CustomerEmail;
  // double InvoiceValue;
  String Language;
  int CustomerReference;
  String UserDefinedField;
  String ApiCustomFileds;
  String API_Token;
  // List<InvoiceItem> InvoiceItems;
  String API_URL;
  // List<Supplier> Suppliers;


  MyFatoorahPayment(
      this.NotificationOption,
      this.CustomerName,
      this.DisplayCurrencyIso,
      this.MobileCountryCode,
      this.CustomerMobile,
      this.CustomerEmail,
      // this.InvoiceValue,
      this.Language,
      this.CustomerReference,
      this.UserDefinedField,
      this.ApiCustomFileds,
      this.API_Token,
      // this.InvoiceItems,
      this.API_URL,
      // this.Suppliers
      );

  factory MyFatoorahPayment.fromJson(Map<String, dynamic> json) =>
      MyFatoorahPayment(
        json['NotificationOption'] as String,
        json['CustomerName'] as String,
        json['DisplayCurrencyIso'] as String,
        json['MobileCountryCode'] as String,
        json['CustomerMobile'] as String,
        json['CustomerEmail'] as String,
        // (json['InvoiceValue'] as num)?.toDouble(),
        json['Language'] as String,
        json['CustomerReference'] as int,
        json['UserDefinedField'] as String,
        json['ApiCustomFileds'] as String,
        json['API_Token'] as String,
        // (json['InvoiceItems'] as List)
        //     ?.map((e) =>
        // e == null ? null : InvoiceItem.fromJson(e as Map<String, dynamic>))
        //     ?.toList(),
        json['API_URL'] as String,
        // (json['Suppliers'] as List)
        //     ?.map((e) =>
        // e == null ? null : Supplier.fromJson(e as Map<String, dynamic>))
        //     ?.toList(),
      );

}









