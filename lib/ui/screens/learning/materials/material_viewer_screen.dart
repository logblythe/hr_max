import 'package:flutter/material.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/learning/materials/learning_material_viewmodel.dart';
import 'package:hrmax/ui/screens/learning/materials/widgets/pdf_viewer.dart';
import 'package:hrmax/ui/screens/learning/materials/widgets/video_player.dart';

class MaterialViewerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseWidget<LearningMaterialViewModel>(
        model: LearningMaterialViewModel(),
        builder: (context, model, child) {
          switch (model.selectedMaterial.materialType) {
            case "pdf":
              return PdfViewer();
              break;
            case "media":
              return VideoPlayerWidget();
              break;
            default:
              return Container();
              break;
          }
        },
      ),
    );
  }
}
