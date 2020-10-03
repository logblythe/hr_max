class MaterialFolder {
  int idFolder;
  String folderName;
  bool containChildFolder;

  MaterialFolder.fromJsonMap(Map<String, dynamic> map)
      : idFolder = map["idFolder"],
        folderName = map["folderName"],
        containChildFolder = map["containChildFolder"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idFolder'] = idFolder;
    data['folderName'] = folderName;
    data['containChildFolder'] = containChildFolder;
    return data;
  }
}
