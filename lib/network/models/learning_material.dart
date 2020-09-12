class LearningMaterial {
  int id;
  String title;
  String fileName;
  String materialType;
  int idCourse;

  LearningMaterial.fromJsonMap(Map<String, dynamic> map)
      : id = map["Id"],
        title = map["title"],
        fileName = map["fileName"],
        materialType = map["materialType"],
        idCourse = map["idCourse"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = id;
    data['title'] = title;
    data['fileName'] = fileName;
    data['materialType'] = materialType;
    data['idCourse'] = idCourse;
    return data;
  }
}
