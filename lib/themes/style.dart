import 'package:flutter/material.dart';

class Style {
  static ThemeData themeData(bool isDark) {
    final colorScheme = isDark
        ? ColorScheme.fromSeed(
            seedColor: const Color(0xff7A0BC0),
            brightness: Brightness.dark,
            // primary: const Color(0xffFA58B6),
          )
        : ColorScheme.fromSeed(
            seedColor: const Color(0xff7A0BC0),
          );
    return ThemeData(colorScheme: colorScheme);
  }

  static ThemeData loginThemeData() {
    return ThemeData(
      colorScheme: const ColorScheme(
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
      ),
    );
  }
}
