import 'package:flutter/material.dart';

enum NavigationOption {
  profile,
  home,
  stocks,
  logout,
}

extension NavigationOptionExtension on NavigationOption {
  Icon get icon {
    switch (this) {
      case NavigationOption.home:
        return const Icon(Icons.home);
      case NavigationOption.stocks:
        return const Icon(Icons.trending_up);
      case NavigationOption.profile:
        return const Icon(Icons.person);
      case NavigationOption.logout:
        return const Icon(Icons.logout);
    }
  }

  String get label {
    switch (this) {
      case NavigationOption.home:
        return 'Home';
      case NavigationOption.stocks:
        return 'Stocks';
      case NavigationOption.profile:
        return 'Profile';
      case NavigationOption.logout:
        return 'Logout';
    }
  }

  ColorScheme get colors {
    switch (this) {
      case NavigationOption.profile:
        return _profileColorScheme;
      case NavigationOption.home:
        return _homeColorScheme;
      case NavigationOption.stocks:
        return _stocksColorScheme;
      default:
        return _defaultColorScheme;
    }
  }

  static const ColorScheme _profileColorScheme = ColorScheme(
    primary: Color(0xffFA58B6),
    surface: Color(0xffFA58B6),
    background: Color(0xff270082),
    secondary: Color(0xff1A1A40),
    error: Color.fromARGB(255, 255, 0, 221),
    onPrimary: Color(0xff000000),
    onSecondary: Color(0xff000000),
    onSurface: Color(0xffffffff),
    onBackground: Color(0xffffffff),
    onError: Color(0xffffffff),
    brightness: Brightness.dark,
  );

  static const ColorScheme _homeColorScheme = ColorScheme(
    primary: Color(0xff7A0BC0),
    surface: Color(0xff7A0BC0),
    background: Color(0xff270082),
    secondary: Color(0xff1A1A40),
    error: Color.fromARGB(255, 255, 0, 221),
    onPrimary: Color(0xff000000),
    onSecondary: Color(0xff000000),
    onSurface: Color(0xffffffff),
    onBackground: Color(0xffffffff),
    onError: Color(0xffffffff),
    brightness: Brightness.dark,
  );

  static const ColorScheme _stocksColorScheme = ColorScheme(
    primary: Color(0xff270082),
    surface: Color(0xff270082),
    background: Color(0xff00FF00),
    secondary: Color(0xff1A1A40),
    error: Color.fromARGB(255, 255, 0, 221),
    onPrimary: Color(0xff000000),
    onSecondary: Color(0xff000000),
    onSurface: Color(0xffffffff),
    onBackground: Color(0xffffffff),
    onError: Color(0xffffffff),
    brightness: Brightness.dark,
  );

  static const ColorScheme _defaultColorScheme = ColorScheme(
    primary: Color(0xffFA58B6),
    surface: Color(0xff7A0BC0),
    background: Color(0xff270082),
    secondary: Color(0xff1A1A40),
    error: Color.fromARGB(255, 255, 0, 221),
    onPrimary: Color(0xff000000),
    onSecondary: Color(0xff000000),
    onSurface: Color(0xffffffff),
    onBackground: Color(0xffffffff),
    onError: Color(0xffffffff),
    brightness: Brightness.dark,
  );
}
