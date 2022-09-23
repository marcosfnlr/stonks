import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_change_state.dart';
import '../preferences/selected_theme_preference.dart';

abstract class ThemeChangeEvent {}

class ToggleDarkness extends ThemeChangeEvent {}

class LoadTheme extends ThemeChangeEvent {}

class ThemeChangeBloc extends Bloc<ThemeChangeEvent, ThemeChangeState> {
  final SelectedThemePreference _themePreference = SelectedThemePreference();

  ThemeChangeBloc() : super(ThemeChangeState.darkTheme) {
    on<LoadTheme>(_onLoadTheme);
    on<ToggleDarkness>(_onToggleDarkness);
  }

  Future<void> _onLoadTheme(_, emit) async {
    bool isDarkTheme = await _themePreference.isDarkTheme();
    emit(
      isDarkTheme ? ThemeChangeState.darkTheme : ThemeChangeState.lightTheme,
    );
  }

  Future<void> _onToggleDarkness(_, emit) async {
    final newState = ThemeChangeState.toggle(state);
    emit(newState);
    _themePreference.setIsDarkTheme(newState.isDark);
  }
}
