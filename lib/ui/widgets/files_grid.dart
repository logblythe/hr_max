import 'package:flutter/material.dart';
import 'package:hrmax/network/models/material_file.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';

class FilesGrid extends StatelessWidget {
  final List<MaterialFile> files;
  final Function(int) onSelectFile;

  const FilesGrid({Key key, this.files, this.onSelectFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.25,
      ),
      itemBuilder: (context, index) {
        var file = files.elementAt(index);
        return Card(
          margin: EdgeInsets.all(16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            onTap: () => onSelectFile(index),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black12),
                  child: UIHelper.buildIcon(file.materialType),
                ),
                UIHelper.verticalSpaceMedium,
                Text(file.circularName,
                    style: Theme.of(context).textTheme.bodyText2),
              ],
            ),
          ),
        );
      },
      itemCount: files.length,
    );
  }
}
