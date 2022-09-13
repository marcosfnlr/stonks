import 'package:flutter/material.dart';

import 'selected_theme_preference.dart';

class SelectedTheme with ChangeNotifier {
  final SelectedThemePreference _themePreference = SelectedThemePreference();
  bool _isDarkTheme = true;

  bool get isDarkTheme => _isDarkTheme;

  Future<void> loadPreference() async {
    _isDarkTheme = await _themePreference.isDarkTheme();
    notifyListeners();
  }

  set isDarkTheme(bool value) {
    _isDarkTheme = value;
    _themePreference.setIsDarkTheme(value);
    notifyListeners();
  }
}
