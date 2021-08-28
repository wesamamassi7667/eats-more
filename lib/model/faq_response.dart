import 'package:eat_more_app/model/stauts.dart';
import 'package:json_annotation/json_annotation.dart';
part 'faq_response.g.dart';

@JsonSerializable()
class FAQResponse{
  StatusResponse status;
  FAQ data;

  FAQResponse(this.status, this.data);
  factory  FAQResponse.fromJson(Map<String, dynamic> json) =>
      _$FAQResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FAQResponseToJson(this);
}

@JsonSerializable()
class FAQ {
  List<Question> faq;

  FAQ(this.faq);
  factory  FAQ.fromJson(Map<String, dynamic> json) =>
      _$FAQFromJson(json);

  Map<String, dynamic> toJson() => _$FAQToJson(this);
}
@JsonSerializable()
class Question {
  int id;
  String ques;
  String answer;
  int sort;

  Question(this.id, this.ques, this.answer, this.sort);
  factory Question .fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}