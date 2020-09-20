import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

@lazySingleton
class NavigationService {
  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> replace(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  pop() {
    return navigatorKey.currentState.pop();
  }

  popAllAndNavigateTo(String routeName) {
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }
}
