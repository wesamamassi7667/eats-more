// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FAQResponse _$FAQResponseFromJson(Map<String, dynamic> json) {
  return FAQResponse(
    json['status'] == null
        ? null
        : StatusResponse.fromJson(json['status'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : FAQ.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FAQResponseToJson(FAQResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

FAQ _$FAQFromJson(Map<String, dynamic> json) {
  return FAQ(
    (json['faq'] as List)
        ?.map((e) =>
            e == null ? null : Question.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FAQToJson(FAQ instance) => <String, dynamic>{
      'faq': instance.faq,
    };

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    json['id'] as int,
    json['ques'] as String,
    json['answer'] as String,
    json['sort'] as int,
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'ques': instance.ques,
      'answer': instance.answer,
      'sort': instance.sort,
    };
