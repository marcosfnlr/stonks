import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/blocs/navigation/nav_bloc.dart';
import '/blocs/navigation/nav_state.dart';
import '/blocs/theme/theme_change_bloc.dart';
import '/blocs/userdata/user_data_bloc.dart';
import '/components/logout_alert.dart';
import '/models/user.dart';
import 'nav_bar.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final themeChangeBloc = BlocProvider.of<ThemeChangeBloc>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NavBloc(),
        ),
        BlocProvider(
          create: (_) => UserDataBloc(user: user),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<UserDataBloc, UserDataState>(
            builder: (context, state) => Text(state.user.name),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(themeChangeBloc.state.isDark
                  ? Icons.dark_mode
                  : Icons.dark_mode_outlined),
              tooltip: 'Dark Mode',
              onPressed: () => themeChangeBloc.add(ToggleDarkness()),
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () => showDialog<bool>(
                context: context,
                builder: (context) => const LogoutAlert(),
              ),
            ),
          ],
        ),
        body: BlocBuilder<NavBloc, NavState>(
          builder: (context, state) {
            return state.screen;
          },
        ),
        bottomNavigationBar: const NavBar(),
      ),
    );
  }
}
