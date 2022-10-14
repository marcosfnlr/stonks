import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/blocs/navigation/nav_bloc.dart';
import '/blocs/theme/theme_change_bloc.dart';
import '/blocs/navigation/nav_state.dart';
import '/components/logout_alert.dart';
import '/models/user.dart';
import 'profile/profile_screen.dart';
import 'stocks/stocks_screen.dart';
import 'nav_bar.dart';

class Screen extends StatelessWidget {
  const Screen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final themeChangeBloc = BlocProvider.of<ThemeChangeBloc>(context);
    return BlocProvider(
      create: (_) => NavBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(user.name),
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
            return ![NavState.profile, NavState.home].contains(state)
                ? const StocksScreen()
                : ProfileScreen(user: user);
          },
        ),
        bottomNavigationBar: const NavBar(),
      ),
    );
  }
}
