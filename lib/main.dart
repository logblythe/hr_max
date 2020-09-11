import 'package:flutter/material.dart';
import 'package:hrmax/app/dialog_manager.dart';
import 'package:hrmax/app/locator.dart';
import 'package:hrmax/app/router.gr.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/core/services/navigation_service.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: widget)),
      ),
      title: APP_TITLE,
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: navigatorKey,
    );
  }
}
