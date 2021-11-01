import 'package:eat_more_app/model/stauts.dart';
import 'package:json_annotation/json_annotation.dart';



@JsonSerializable()
class FAQ {
  List<Question> faq;

  FAQ(this.faq);
  factory  FAQ.fromJson(Map<String, dynamic> json) =>
      FAQ(
        (json['faq'] as List)
            ?.map((e) =>
        e == null ? null : Question.fromJson(e as Map<String, dynamic>))
            ?.toList(),
      );

}
@JsonSerializable()
class Question {
  int id;
  String ques;
  String answer;
  int sort;

  Question(this.id, this.ques, this.answer, this.sort);
  factory Question .fromJson(Map<String, dynamic> json) =>
      Question(
        json['id'] as int,
        json['ques'] as String,
        json['answer'] as String,
        json['sort'] as int,
      );

}