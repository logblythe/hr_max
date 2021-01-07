// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/screens/home/home_screen.dart';
import '../ui/screens/initial/initial_screen.dart';
import '../ui/screens/learning/exam/exams_screen.dart';
import '../ui/screens/learning/instructions/instructions_screen.dart';
import '../ui/screens/learning/learning_dashboard/learning_dashboard_screen.dart';
import '../ui/screens/learning/materials/learning_materials_screen.dart';
import '../ui/screens/learning/materials/material_viewer_screen.dart';
import '../ui/screens/learning/question/questions_screen.dart';
import '../ui/screens/learning/result/result_screen.dart';
import '../ui/screens/login/login_screen.dart';
import '../ui/screens/materials/files/files_screen.dart';
import '../ui/screens/materials/folder/folder_screen.dart';
import '../ui/screens/profile/profile_screen.dart';

class Routes {
  static const String InitialRoute = '/';
  static const String ExamRoute = '/exams-screen';
  static const String HomeRoute = '/home-screen';
  static const String InstructionRoute = '/instructions-screen';
  static const String LearningDashRoute = '/learning-dashboard-screen';
  static const String LoginRoute = '/login-screen';
  static const String MaterialsRoute = '/learning-material-screen';
  static const String MaterialViewerRoute = '/material-viewer-screen';
  static const String FolderRoute = '/folder-screen';
  static const String FilesRoute = '/files-screen';
  static const String ProfileRoute = '/profile-screen';
  static const String QuestionRoute = '/questions-screen';
  static const String ResultRoute = '/result-screen';
  static const all = <String>{
    InitialRoute,
    ExamRoute,
    HomeRoute,
    InstructionRoute,
    LearningDashRoute,
    LoginRoute,
    MaterialsRoute,
    MaterialViewerRoute,
    FolderRoute,
    FilesRoute,
    ProfileRoute,
    QuestionRoute,
    ResultRoute,
  };
}

class CustomRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.InitialRoute, page: InitialScreen),
    RouteDef(Routes.ExamRoute, page: ExamsScreen),
    RouteDef(Routes.HomeRoute, page: HomeScreen),
    RouteDef(Routes.InstructionRoute, page: InstructionsScreen),
    RouteDef(Routes.LearningDashRoute, page: LearningDashboardScreen),
    RouteDef(Routes.LoginRoute, page: LoginScreen),
    RouteDef(Routes.MaterialsRoute, page: LearningMaterialScreen),
    RouteDef(Routes.MaterialViewerRoute, page: MaterialViewerScreen),
    RouteDef(Routes.FolderRoute, page: FolderScreen),
    RouteDef(Routes.FilesRoute, page: FilesScreen),
    RouteDef(Routes.ProfileRoute, page: ProfileScreen),
    RouteDef(Routes.QuestionRoute, page: QuestionsScreen),
    RouteDef(Routes.ResultRoute, page: ResultScreen),
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
    ExamsScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ExamsScreen(),
        settings: data,
      );
    },
    HomeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeScreen(),
        settings: data,
      );
    },
    InstructionsScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => InstructionsScreen(),
        settings: data,
      );
    },
    LearningDashboardScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LearningDashboardScreen(),
        settings: data,
      );
    },
    LoginScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginScreen(),
        settings: data,
      );
    },
    LearningMaterialScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LearningMaterialScreen(),
        settings: data,
      );
    },
    MaterialViewerScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MaterialViewerScreen(),
        settings: data,
      );
    },
    FolderScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => FolderScreen(),
        settings: data,
      );
    },
    FilesScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => FilesScreen(),
        settings: data,
      );
    },
    ProfileScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileScreen(),
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
  };
}
