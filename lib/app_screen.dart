import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stonks/stocks_screen.dart';

import 'user.dart';
import 'nav_option.dart';
import 'nav_bar.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'ticker.dart';

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
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: _selectedScreen.colors,
      ),
      child: AlertDialog(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: _selectedScreen.colors,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.user.name),
          actions: <Widget>[
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
      ),
    );
  }

  List<Ticker> _mockTickers() {
    return [
      {
        'symbol': 'PETR4.SA',
        'name': 'Petr??leo Brasileiro S.A.',
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
        'name': 'Petr??leo Brasileiro S.A.',
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
