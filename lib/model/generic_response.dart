import 'package:eat_more_app/model/stauts.dart';
import 'package:eat_more_app/typdef/model_creator.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class GenericResponse<T>{
  StatusResponse status;
  T data;

  GenericResponse(this.status, this.data);

  factory GenericResponse.fromJson(Map<String, dynamic> json,ModelCreator<T> createModel) => GenericResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : createModel(json['data']), // it means converts map json['data'] to model like cart.fromJson(json['data])
  );
}

