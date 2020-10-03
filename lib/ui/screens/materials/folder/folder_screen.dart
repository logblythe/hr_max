import 'package:flutter/material.dart';
import 'package:hrmax/network/models/material_folder.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/materials/folder/folder_viewmodel.dart';
import 'package:hrmax/ui/widgets/folders_grid.dart';

class FolderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Folders')),
      body: BaseWidget<FolderViewmodel>(
        model: FolderViewmodel(),
        onModelReady: (model) {
          model.fetchFolders();
        },
        builder: (context, model, child) {
          if (model.loading) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<MaterialFolder> _folders = model.materialFolders;
            return FoldersGrid(
              folders: _folders,
              onFolderSelect: (index) {
                model.selectFolder(_folders.elementAt(index));
              },
            );
          }
        },
      ),
    );
  }
}
