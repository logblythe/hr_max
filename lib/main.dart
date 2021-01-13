import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hrmax/app/locator.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/core/services/navigation_service.dart';

import 'app/router.gr.dart';

const debug = true; //setting true to enable logs of FlutterDownloader

void main() async {
  setupLocator();
  await FlutterDownloader.initialize(debug: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      onGenerateRoute: CustomRouter().onGenerateRoute,
      navigatorKey: navigatorKey,
    );
  }
}
