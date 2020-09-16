import 'package:flutter/material.dart';
import 'package:hrmax/core/constants/image_paths.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/initial/initial_viewmodel.dart';

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<InitialViewmodel>(
      model: InitialViewmodel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          body: Container(
            child: Center(child: Image.asset(ImagePath.LOGO)),
          ),
        );
      },
    );
  }
}
