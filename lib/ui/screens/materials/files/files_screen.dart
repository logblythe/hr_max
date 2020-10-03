import 'package:flutter/material.dart';
import 'package:hrmax/network/models/material_folder.dart';
import 'package:hrmax/network/response.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/materials/files/files_viewmodel.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';
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
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.25,
      ),
      itemBuilder: (context, index) {
        var file = model.files.elementAt(index);
        return Card(
          margin: EdgeInsets.all(16),
          elevation: 8,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            onTap: () => model.selectFile(file),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black12),
                  child: UIHelper.buildIcon(file.materialType),
                ),
                UIHelper.verticalSpaceMedium,
                Text(file.circularName,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2),
              ],
            ),
          ),
        );
      },
      itemCount: model.files.length,
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
