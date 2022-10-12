import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'nav_bar.dart';
import 'profile/profile_screen.dart';
import 'stocks/stocks_screen.dart';
import '../blocs/navigation/nav_bloc.dart';
import '../blocs/theme/theme_change_bloc.dart';
import '../blocs/navigation/nav_state.dart';
import '../components/logout_alert.dart';
import '../models/ticker.dart';
import '../models/user.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    final themeChangeBloc = BlocProvider.of<ThemeChangeBloc>(context);
    return BlocProvider(
      create: (_) => NavBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.user.name),
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
                ? StocksScreen(tickers: _mockTickers())
                : ProfileScreen(user: widget.user);
          },
        ),
        bottomNavigationBar: const NavBar(),
      ),
    );
  }

  List<Ticker> _mockTickers() {
    return [
      {
        'symbol': 'PETR4.SA',
        'name': 'Petróleo Brasileiro S.A.',
      },
      {
        'symbol': 'PETR3.SA',
        'name': 'Petrobras',
      },
      {
        'symbol': 'VALE3.SA',
        'name': 'Vale S.A.',
      },
      {
        'symbol': 'BBAS3.SA',
        'name': 'Banco do Brasil S.A.',
      },
      {
        'symbol': 'PETR4.SA',
        'name': 'Petróleo Brasileiro S.A.',
      },
      {
        'symbol': 'PETR3.SA',
        'name': 'Petrobras',
      },
      {
        'symbol': 'VALE3.SA',
        'name': 'Vale S.A.',
      },
      {
        'symbol': 'BBAS3.SA',
        'name': 'Banco do Brasil S.A.',
      },
    ].map((tick) => Ticker(tick['symbol']!, tick['name']!)).toList();
  }
}
