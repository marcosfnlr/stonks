import 'package:flutter/material.dart';

import 'user.dart';
import 'nav_option.dart';
import 'nav_bar.dart';
import 'login_screen.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  NavigationOption _selectedScreen = NavigationOption.home;

  void onNavItemTap(int index) {
    if (index == NavigationOption.logout.index) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      setState(() {
        _selectedScreen = NavigationOption.values[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: _selectedScreen.colors,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedItemColor: Colors.grey[350],
          selectedItemColor: Colors.white,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.user.name),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(widget.user.email),
        ),
        bottomNavigationBar: NavBar(
          selectedOption: _selectedScreen,
          onTap: onNavItemTap,
        ),
      ),
    );
  }
}
