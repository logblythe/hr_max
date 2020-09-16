// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/screens/exam/exams_screen.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/initial/initial_screen.dart';
import '../ui/screens/learning_dashboard/learning_dashboard_screen.dart';
import '../ui/screens/login/login_screen.dart';
import '../ui/screens/materials/material_viewer_screen.dart';
import '../ui/screens/materials/materials_screen.dart';
import '../ui/screens/question/questions_screen.dart';
import '../ui/screens/result/result_screen.dart';

class Routes {
  static const String InitialRoute = '/';
  static const String LoginRoute = '/login-screen';
  static const String HomeRoute = '/home-screen';
  static const String LearningDashRoute = '/learning-dashboard-screen';
  static const String ExamRoute = '/exams-screen';
  static const String QuestionRoute = '/questions-screen';
  static const String ResultRoute = '/result-screen';
  static const String MaterialsRoute = '/material-screen';
  static const String MaterialViewerRoute = '/material-viewer-screen';
  static const all = <String>{
    InitialRoute,
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
    RouteDef(Routes.InitialRoute, page: InitialScreen),
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
    InitialScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => InitialScreen(),
        settings: data,
      );
    },
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
      return MaterialPageRoute<dynamic>(
        builder: (context) => ResultScreen(),
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
