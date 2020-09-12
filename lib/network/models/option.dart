
class Option {
  int id;
  int questionId;
  String name;
  bool isAnswer;

	Option.fromJsonMap(Map<String, dynamic> map):
		id = map["Id"],
		questionId = map["questionId"],
		name = map["name"],
		isAnswer = map["isAnswer"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Id'] = id;
		data['questionId'] = questionId;
		data['name'] = name;
		data['isAnswer'] = isAnswer;
		return data;
	}
}
