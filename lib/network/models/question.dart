import 'package:hrmax/network/models/options.dart';
import 'package:hrmax/network/models/options.dart';

class Question {

  int id;
  String name;
  String questionTypeId;
  double markPerQuestion;
  double negativeMarkingScore;
  List<Option> options;
  Object correctAnswer;
  Object optionType;

	Question.fromJsonMap(Map<String, dynamic> map): 
		id = map["Id"],
		name = map["Name"],
		questionTypeId = map["QuestionTypeId"],
		markPerQuestion = map["MarkPerQuestion"],
		negativeMarkingScore = map["NegativeMarkingScore"],
		options = List<Option>.from(map["Options"].map((it) => Option.fromJsonMap(it))),
		correctAnswer = map["CorrectAnswer"],
		optionType = map["OptionType"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Id'] = id;
		data['Name'] = name;
		data['QuestionTypeId'] = questionTypeId;
		data['MarkPerQuestion'] = markPerQuestion;
		data['NegativeMarkingScore'] = negativeMarkingScore;
		data['Options'] = options != null ?
			this.options.map((v) => v.toJson()).toList()
			: null;
		data['CorrectAnswer'] = correctAnswer;
		data['OptionType'] = optionType;
		return data;
	}
}
