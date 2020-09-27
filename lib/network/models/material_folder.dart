class MaterialFolder {
  int IdFolder;
  String FolderName;

  MaterialFolder.fromJsonMap(Map<String, dynamic> map)
      : IdFolder = map["IdFolder"],
        FolderName = map["FolderName"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdFolder'] = IdFolder;
    data['FolderName'] = FolderName;
    return data;
  }
}
