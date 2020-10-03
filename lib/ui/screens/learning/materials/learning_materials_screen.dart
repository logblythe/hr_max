import 'package:flutter/material.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/learning/materials/learning_material_viewmodel.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';

class LearningMaterialScreen extends StatelessWidget {
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
          if (model.materials.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.hourglass_empty,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  UIHelper.verticalSpaceMedium,
                  Text(
                    "No learning materials available for this course",
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
            );
          }
          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              var material = model.materials.elementAt(index);
              return Card(
                margin: EdgeInsets.all(16),
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: InkWell(
                    onTap: () => model.selectMaterial(material),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UIHelper.buildIcon(material.materialType),
                        UIHelper.verticalSpaceMedium,
                        Text(material.title,
                            style: Theme.of(context).textTheme.bodyText2),
                      ],
                    )),
              );
            },
            itemCount: model.materials.length,
          );
        },
      ),
    );
  }
}
