// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../core/services/api_service.dart';
import '../core/services/dialog_service.dart';
import '../core/services/navigation_service.dart';
import '../core/services/user_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<ApiService>(() => ApiService());
  gh.lazySingleton<DialogService>(() => DialogService());
  gh.lazySingleton<NavigationService>(() => NavigationService());
  gh.lazySingleton<UserService>(
      () => UserService(apiService: get<ApiService>()));
  return get;
}
