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
          dynamic selection = model.selectedMaterial ?? model.selectedFile;
          switch (selection.materialType) {
            case "pdf":
              return PdfViewer(url: selection.previewLink);
              break;
            case "media":
              return VideoPlayerWidget(url: selection.previewLink);
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
