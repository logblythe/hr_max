class Quiz {
  int id;
  String name;
  String description;

  Quiz.fromJsonMap(Map<String, dynamic> map)
      : id = map["Id"],
        name = map["name"],
        description = map["description"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
