
class Option {

  int id;
  int questionId;
  String name;
  bool isAnswer;

	Option.fromJsonMap(Map<String, dynamic> map):
		id = map["Id"],
		questionId = map["QuestionId"],
		name = map["Name"],
		isAnswer = map["IsAnswer"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Id'] = id;
		data['QuestionId'] = questionId;
		data['Name'] = name;
		data['IsAnswer'] = isAnswer;
		return data;
	}
}
