import 'package:hrmax/network/models/option.dart';

class Question {
  int id;
  String name;
  String questionTypeId;
  double markPerQuestion;
  double negativeMarkingScore;
  List<Option> options;
  List<Option> correctAnswer;
  Object optionType;

  Question.fromJsonMap(Map<String, dynamic> map)
      : id = map["Id"],
        name = map["name"],
        questionTypeId = map["questionTypeId"],
        markPerQuestion = map["markPerQuestion"],
        negativeMarkingScore = map["negativeMarkingScore"],
        options = List<Option>.from(
            map["options"].map((it) => Option.fromJsonMap(it))),
        correctAnswer = map["correctAnswer"] != null
            ? List<Option>.from(
                map["correctAnswer"].map((it) => Option.fromJsonMap(it)))
            : [],
        optionType = map["optionType"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = id;
    data['name'] = name;
    data['questionTypeId'] = questionTypeId;
    data['markPerQuestion'] = markPerQuestion;
    data['negativeMarkingScore'] = negativeMarkingScore;
    data['options'] =
        options != null ? this.options.map((v) => v.toJson()).toList() : null;
    data['correctAnswer'] = correctAnswer;
    data['optionType'] = optionType;
    return data;
  }
}
