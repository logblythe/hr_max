class MaterialFile {
  int IdFile;
  int IdFolder;
  int IDDepartment;
  String RefNumber;
  String CircularName;
  String CircularSummary;
  String DocumentNameGuid;
  String BasePath;
  String MaterialType;
  String previewLink;

  MaterialFile.fromJsonMap(Map<String, dynamic> map)
      : IdFile = map["IdFile"],
        IdFolder = map["IdFolder"],
        IDDepartment = map["IDDepartment"],
        RefNumber = map["RefNumber"],
        CircularName = map["CircularName"],
        CircularSummary = map["CircularSummary"],
        DocumentNameGuid = map["DocumentNameGuid"],
        BasePath = map["BasePath"],
        MaterialType = map["MaterialType"],
        previewLink = map["previewLink"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdFile'] = IdFile;
    data['IdFolder'] = IdFolder;
    data['IDDepartment'] = IDDepartment;
    data['RefNumber'] = RefNumber;
    data['CircularName'] = CircularName;
    data['CircularSummary'] = CircularSummary;
    data['DocumentNameGuid'] = DocumentNameGuid;
    data['BasePath'] = BasePath;
    data['MaterialType'] = MaterialType;
    data['previewLink'] = previewLink;
    return data;
  }
}
