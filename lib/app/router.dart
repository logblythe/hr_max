import 'package:auto_route/auto_route_annotations.dart';
import 'package:hrmax/ui/screens/home/home_screen.dart';
import 'package:hrmax/ui/screens/initial/initial_screen.dart';
import 'package:hrmax/ui/screens/learning/exam/exams_screen.dart';
import 'package:hrmax/ui/screens/learning/instructions/instructions_screen.dart';
import 'package:hrmax/ui/screens/learning/learning_dashboard/learning_dashboard_screen.dart';
import 'package:hrmax/ui/screens/learning/materials/learning_materials_screen.dart';
import 'package:hrmax/ui/screens/learning/materials/material_viewer_screen.dart';
import 'package:hrmax/ui/screens/learning/question/questions_screen.dart';
import 'package:hrmax/ui/screens/learning/result/result_screen.dart';
import 'package:hrmax/ui/screens/login/login_screen.dart';
import 'package:hrmax/ui/screens/materials/files/files_screen.dart';
import 'package:hrmax/ui/screens/materials/folder/folder_screen.dart';
import 'package:hrmax/ui/screens/profile/profile_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: InitialScreen, name: "InitialRoute", initial: true),
    MaterialRoute(page: ExamsScreen, name: "ExamRoute"),
    MaterialRoute(page: HomeScreen, name: "HomeRoute"),
    MaterialRoute(page: InstructionsScreen, name: "InstructionRoute"),
    MaterialRoute(page: LearningDashboardScreen, name: "LearningDashRoute"),
    MaterialRoute(page: LoginScreen, name: "LoginRoute"),
    MaterialRoute(page: LearningMaterialScreen, name: "MaterialsRoute"),
    MaterialRoute(page: MaterialViewerScreen, name: "MaterialViewerRoute"),
    MaterialRoute(page: FolderScreen, name: "FolderRoute"),
    MaterialRoute(page: FilesScreen, name: "FilesRoute"),
    MaterialRoute(page: ProfileScreen, name: "ProfileRoute"),
    MaterialRoute(page: QuestionsScreen, name: "QuestionRoute"),
    MaterialRoute(page: ResultScreen, name: "ResultRoute"),
  ],
)
class $Router {}
