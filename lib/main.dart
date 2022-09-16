import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:our_structures/our_structures.dart';

import 'models/selected_theme.dart';
import 'screens/login/login_screen.dart';
import 'themes/style.dart';

void main() {
  runApp(const StonksApp());
}

class StonksApp extends StatelessWidget {
  const StonksApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SelectedTheme>(
      create: (context) {
        SelectedTheme selectedTheme = SelectedTheme();
        selectedTheme.loadPreference();
        return selectedTheme;
      },
      child: Consumer<SelectedTheme>(
        builder: (BuildContext context, SelectedTheme batata, Widget? child) {
          return MaterialApp(
            theme: Style.themeData(batata.isDarkTheme),
            home: const LoginScreen(),
          );
        },
      ),
    );
  }
}
