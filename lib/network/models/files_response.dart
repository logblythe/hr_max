import 'package:hrmax/network/models/material_file.dart';
import 'package:hrmax/network/models/material_folder.dart';

class FilesResponse {
  List<MaterialFile> files;
  List<MaterialFolder> folders;

  FilesResponse.fromJsonMap(Map<String, dynamic> json)
      : files = json['fileModel'] != null
            ? List.from(
                json['fileModel'].map((e) => MaterialFile.fromJsonMap(e)))
            : [],
        folders = json['folderModel'] != null
            ? List.from(
                json['folderModel'].map((e) => MaterialFolder.fromJsonMap(e)))
            : [];
}
