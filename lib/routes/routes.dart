import 'package:flutter/material.dart';

import '/models/user.dart';
import '/screens/app_screen.dart';
import '/screens/login/login_screen.dart';

enum Routes {
  login('/login', _loginBuilder),
  app('/app', _profileBuilder),
  ;

  final String name;
  final Widget Function(BuildContext) builder;

  const Routes(this.name, this.builder);

  static Widget _loginBuilder(BuildContext context) => const LoginScreen();
  static Widget _profileBuilder(BuildContext context) => AppScreen(
        user: ModalRoute.of(context)!.settings.arguments as User,
      );

  static Map<String, Widget Function(BuildContext)> buildMap() {
    return {for (var v in values) v.name: v.builder};
  }
}
