import 'package:flutter/material.dart';
import 'package:hrmax/network/models/material_folder.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';

class FoldersGrid extends StatelessWidget {
  final List<MaterialFolder> folders;
  final Function(int) onFolderSelect;

  const FoldersGrid({
    Key key,
    this.folders,
    this.onFolderSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.25,
      ),
      shrinkWrap: true,
      itemCount: folders.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(16),
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            onTap: () => onFolderSelect(index),
            // model.selectFolder(folders.elementAt(index))
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black12),
                  child: Icon(
                    Icons.folder,
                    size: 32,
                    color: Color(0xff026ec1),
                  ),
                ),
                UIHelper.verticalSpaceMedium,
                Text(folders.elementAt(index).folderName),
              ],
            ),
          ),
        );
      },
    );
  }
}
