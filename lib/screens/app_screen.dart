import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'nav_bar.dart';
import 'login/login_screen.dart';
import 'profile/profile_screen.dart';
import 'stocks/stocks_screen.dart';
import '../models/nav_option.dart';
import '../models/selected_theme.dart';
import '../models/ticker.dart';
import '../models/user.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  NavigationOption _selectedScreen = NavigationOption.home;

  void onNavItemTap(int index) {
    setState(() {
      _selectedScreen = NavigationOption.values[index];
    });
  }

  Widget _buildLogoutAlert(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('Sure you wanna leave us?'),
      actions: <Widget>[
        TextButton.icon(
          onPressed: () => Navigator.pop(context, true),
          icon: const Text('Stay'),
          label: const Icon(Icons.sentiment_very_satisfied),
        ),
        TextButton.icon(
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            ((_) => false),
          ),
          icon: const Text('Leave'),
          label: const Icon(Icons.heart_broken),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
        actions: <Widget>[
          Consumer<SelectedTheme>(
            builder: (
              BuildContext context,
              SelectedTheme selectedTheme,
              Widget? child,
            ) {
              return IconButton(
                icon: Icon(selectedTheme.isDarkTheme
                    ? Icons.dark_mode
                    : Icons.dark_mode_outlined),
                tooltip: 'Dark Mode',
                onPressed: () =>
                    selectedTheme.isDarkTheme = !selectedTheme.isDarkTheme,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => showDialog<bool>(
              context: context,
              builder: _buildLogoutAlert,
            ),
          ),
        ],
      ),
      body: ![NavigationOption.profile, NavigationOption.home]
              .contains(_selectedScreen)
          ? StocksScreen(tickers: _mockTickers())
          : ProfileScreen(user: widget.user),
      bottomNavigationBar: NavBar(
        selectedOption: _selectedScreen,
        onTap: onNavItemTap,
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
