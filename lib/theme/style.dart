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
}
