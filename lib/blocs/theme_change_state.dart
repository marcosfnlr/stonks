enum ThemeChangeState {
  darkTheme(isDark: true),
  lightTheme(isDark: false);

  const ThemeChangeState({required this.isDark});
  final bool isDark;

  static ThemeChangeState toggle(ThemeChangeState state) {
    return state.isDark
        ? ThemeChangeState.lightTheme
        : ThemeChangeState.darkTheme;
  }
}