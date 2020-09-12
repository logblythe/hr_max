// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../network/models/options.dart';
import '../ui/screens/exam/exams_screen.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/learning_dashboard/learning_dashboard_screen.dart';
import '../ui/screens/login/login_screen.dart';
import '../ui/screens/materials/material_viewer_screen.dart';
import '../ui/screens/materials/materials_screen.dart';
import '../ui/screens/question/questions_screen.dart';
import '../ui/screens/result_screen.dart';

class Routes {
  static const String LoginRoute = '/';
  static const String HomeRoute = '/home-screen';
  static const String LearningDashRoute = '/learning-dashboard-screen';
  static const String ExamRoute = '/exams-screen';
  static const String QuestionRoute = '/questions-screen';
  static const String ResultRoute = '/result-screen';
  static const String MaterialsRoute = '/material-screen';
  static const String MaterialViewerRoute = '/material-viewer-screen';
  static const all = <String>{
    LoginRoute,
    HomeRoute,
    LearningDashRoute,
    ExamRoute,
    QuestionRoute,
    ResultRoute,
    MaterialsRoute,
    MaterialViewerRoute,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.LoginRoute, page: LoginScreen),
    RouteDef(Routes.HomeRoute, page: HomeScreen),
    RouteDef(Routes.LearningDashRoute, page: LearningDashboardScreen),
    RouteDef(Routes.ExamRoute, page: ExamsScreen),
    RouteDef(Routes.QuestionRoute, page: QuestionsScreen),
    RouteDef(Routes.ResultRoute, page: ResultScreen),
    RouteDef(Routes.MaterialsRoute, page: MaterialScreen),
    RouteDef(Routes.MaterialViewerRoute, page: MaterialViewerScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    LoginScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginScreen(),
        settings: data,
      );
    },
    HomeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeScreen(),
        settings: data,
      );
    },
    LearningDashboardScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LearningDashboardScreen(),
        settings: data,
      );
    },
    ExamsScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ExamsScreen(),
        settings: data,
      );
    },
    QuestionsScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => QuestionsScreen(),
        settings: data,
      );
    },
    ResultScreen: (data) {
      final args = data.getArgs<ResultScreenArguments>(
        orElse: () => ResultScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ResultScreen(
          key: args.key,
          answersMap: args.answersMap,
          showResult: args.showResult,
          showCorrectAnswer: args.showCorrectAnswer,
        ),
        settings: data,
      );
    },
    MaterialScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MaterialScreen(),
        settings: data,
      );
    },
    MaterialViewerScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MaterialViewerScreen(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ResultScreen arguments holder class
class ResultScreenArguments {
  final Key key;
  final Map<int, List<Option>> answersMap;
  final bool showResult;
  final bool showCorrectAnswer;
  ResultScreenArguments(
      {this.key, this.answersMap, this.showResult, this.showCorrectAnswer});
}
