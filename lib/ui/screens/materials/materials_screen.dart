import 'package:flutter/material.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/materials/learning_material_viewmodel.dart';

class MaterialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Learning materials')),
      body: BaseWidget<LearningMaterialViewModel>(
        model: LearningMaterialViewModel(),
        onModelReady: (model) => model.fetchLearningMaterials(),
        builder: (context, model, child) {
          if (model.loading) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemBuilder: (context, index) {
              var material = model.materials.elementAt(index);
              return Card(
                child: ListTile(
                  onTap: () => model.selectMaterial(material),
                  title: Text(material.title.toUpperCase()),
                  subtitle: Text(material.fileName),
                  leading: Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: buildIcon(material.materialType),
                  ),
                ),
              );
            },
            itemCount: model.materials.length,
          );
        },
      ),
    );
  }

  buildIcon(String materialType) {
    if (materialType == "pdf") {
      return Icon(Icons.picture_as_pdf);
    } else if (materialType == "media") {
      return Icon(Icons.video_library);
    } else {
      return Icon(Icons.not_interested);
    }
  }
}
