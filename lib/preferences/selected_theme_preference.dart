import 'package:shared_preferences/shared_preferences.dart';

class SelectedThemePreference {
  static const THEME_STATUS = "ISDARKTHEME";

  Future<void> setIsDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> isDarkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? true;
  }
}
