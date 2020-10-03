import 'package:flutter/material.dart';
import 'package:hrmax/network/models/material_file.dart';
import 'package:hrmax/network/models/material_folder.dart';
import 'package:hrmax/network/response.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/materials/files/files_viewmodel.dart';
import 'package:hrmax/ui/widgets/files_grid.dart';
import 'package:hrmax/ui/widgets/folders_grid.dart';

class FilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<FilesViewmodel>(
      model: FilesViewmodel(),
      onModelReady: (model) {
        model.fetchFiles();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(title: Text(model.selectedFolder.folderName)),
          body: body(model),
        );
      },
    );
  }

  Widget body(model) {
    switch (model.status) {
      case Status.LOADING:
        return Center(child: CircularProgressIndicator());
        break;
      case Status.COMPLETED:
        return ListView(
          children: [
            fileList(model),
            folderList(model),
          ],
        );
        break;
      case Status.ERROR:
        return Container();
        break;
      case Status.PAGINATING:
        return Container();
        break;
      default:
        return Container();
    }
  }

  Widget fileList(FilesViewmodel model) {
    List<MaterialFile> _files = model.files;
    return FilesGrid(
      files: _files,
      onSelectFile: (index) {
        model.selectFile(_files.elementAt(index));
      },
    );
  }

  Widget folderList(FilesViewmodel model) {
    List<MaterialFolder> _folders = model.materialFolders;
    return FoldersGrid(
      folders: _folders,
      onFolderSelect: (index) {
        model.selectFolder(_folders.elementAt(index));
      },
    );
  }
}
