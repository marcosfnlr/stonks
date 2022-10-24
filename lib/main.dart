import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:our_structures/our_structures.dart';

import 'blocs/theme/theme_change_bloc.dart';
import 'blocs/theme/theme_change_state.dart';
import 'routes/routes.dart';
import 'themes/style.dart';

void main() {
  runApp(const StonksApp());
}

class StonksApp extends StatelessWidget {
  const StonksApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return ThemeChangeBloc()..add(LoadTheme());
      },
      child: BlocBuilder<ThemeChangeBloc, ThemeChangeState>(
        builder: (_, state) {
          return MaterialApp(
            theme: Style.themeData(state.isDark),
            routes: Routes.buildMap(),
            initialRoute: Routes.login.name,
          );
        },
      ),
    );
  }
}
