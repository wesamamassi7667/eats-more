// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_myfatoorah_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyFatoorahResponse _$MyFatoorahResponseFromJson(Map<String, dynamic> json) {
  return MyFatoorahResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : MyFatoorah.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MyFatoorahResponseToJson(MyFatoorahResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

MyFatoorah _$MyFatoorahFromJson(Map<String, dynamic> json) {
  return MyFatoorah(
    json['base_url'] as String,
    json['token'] as String,
  );
}

Map<String, dynamic> _$MyFatoorahToJson(MyFatoorah instance) =>
    <String, dynamic>{
      'base_url': instance.base_url,
      'token': instance.token,
    };

MyFatoorahPaymentResponse _$MyFatoorahPaymentResponseFromJson(
    Map<String, dynamic> json) {
  return MyFatoorahPaymentResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : MyFatoorahPayment.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MyFatoorahPaymentResponseToJson(
        MyFatoorahPaymentResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

MyFatoorahPayment _$MyFatoorahPaymentFromJson(Map<String, dynamic> json) {
  return MyFatoorahPayment(
    json['NotificationOption'] as String,
    json['CustomerName'] as String,
    json['DisplayCurrencyIso'] as String,
    json['MobileCountryCode'] as String,
    json['CustomerMobile'] as String,
    json['CustomerEmail'] as String,
    (json['InvoiceValue'] as num)?.toDouble(),
    json['Language'] as String,
    json['CustomerReference'] as int,
    json['UserDefinedField'] as String,
    json['ApiCustomFileds'] as String,
    json['API_Token'] as String,
    (json['InvoiceItems'] as List)
        ?.map((e) =>
            e == null ? null : InvoiceItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['API_URL'] as String,
  );
}

Map<String, dynamic> _$MyFatoorahPaymentToJson(MyFatoorahPayment instance) =>
    <String, dynamic>{
      'NotificationOption': instance.NotificationOption,
      'CustomerName': instance.CustomerName,
      'DisplayCurrencyIso': instance.DisplayCurrencyIso,
      'MobileCountryCode': instance.MobileCountryCode,
      'CustomerMobile': instance.CustomerMobile,
      'CustomerEmail': instance.CustomerEmail,
      'InvoiceValue': instance.InvoiceValue,
      'Language': instance.Language,
      'CustomerReference': instance.CustomerReference,
      'UserDefinedField': instance.UserDefinedField,
      'ApiCustomFileds': instance.ApiCustomFileds,
      'API_Token': instance.API_Token,
      'InvoiceItems': instance.InvoiceItems,
      'API_URL': instance.API_URL,
    };
