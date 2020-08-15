
class Quiz {

  int Id;
  String name;
  String description;

	Quiz.fromJsonMap(Map<String, dynamic> map): 
		Id = map["Id"],
		name = map["name"],
		description = map["description"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Id'] = Id;
		data['name'] = name;
		data['description'] = description;
		return data;
	}
}
