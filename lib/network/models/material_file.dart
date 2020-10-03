class MaterialFile {
  int idFile;
  int idFolder;
  int idDepartment;
  String refNumber;
  String circularName;
  String circularSummary;
  String documentNameGuid;
  String basePath;
  String materialType;
  String previewLink;

  MaterialFile.fromJsonMap(Map<String, dynamic> map)
      : idFile = map["idFile"],
        idFolder = map["idFolder"],
        idDepartment = map["idDepartment"],
        refNumber = map["refNumber"],
        circularName = map["circularName"],
        circularSummary = map["circularSummary"],
        documentNameGuid = map["documentNameGuid"],
        basePath = map["basePath"],
        materialType = map["materialType"],
        previewLink = map["previewLink"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idFile'] = idFile;
    data['idFolder'] = idFolder;
    data['idDepartment'] = idDepartment;
    data['refNumber'] = refNumber;
    data['circularName'] = circularName;
    data['circularSummary'] = circularSummary;
    data['documentNameGuid'] = documentNameGuid;
    data['basePath'] = basePath;
    data['materialType'] = materialType;
    data['previewLink'] = previewLink;
    return data;
  }
}
