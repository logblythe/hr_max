import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/materials/learning_material_viewmodel.dart';

class PdfViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<LearningMaterialViewModel>(
      model: LearningMaterialViewModel(),
      builder: (context, model, child) {
        // LearningMaterial material = model.selectedMaterial;
        return PDF().cachedFromUrl(
          "https://google-developer-training.github.io/android-developer-fundamentals-course-concepts/en/android-developer-fundamentals-course-concepts-en.pdf",
          placeholder: (progress) => Center(child: Text('$progress %')),
          errorWidget: (error) => Center(child: Text(error.toString())),
        );
      },
    );
  }
}