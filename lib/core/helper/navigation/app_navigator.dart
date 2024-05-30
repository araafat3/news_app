import 'package:flutter/material.dart';

class AppNavigator {
  static AppNavigator? _instance;

  AppNavigator._internal();

  factory AppNavigator() {
    return _instance??=AppNavigator._internal();
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  RouteSettings? routeSettings;

  NavigatorState currentState() => navigatorKey.currentState!;

  BuildContext currentContext() => navigatorKey.currentContext!;

  Future<Object?> push({required String routeName, Object? arguments}) {
    return currentState().pushNamed(routeName, arguments: arguments);
  }

  void goBack({Object? result}) {
    if(currentState().canPop() ){
      currentState().pop(result);
    }
  }

}
