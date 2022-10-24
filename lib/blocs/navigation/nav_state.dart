import 'package:flutter/material.dart';

import '/screens/profile/profile_screen.dart';
import '/screens/stocks/stocks_screen.dart';

enum NavState {
  dummy(Icon(Icons.sports_volleyball), 'Volley', StocksScreen()),
  home(Icon(Icons.home), 'Home', ProfileScreen()),
  stocks(Icon(Icons.trending_up), 'Stocks', StocksScreen()),
  profile(Icon(Icons.person), 'Profile', ProfileScreen());

  final Icon icon;
  final String label;
  final Widget screen;
  const NavState(this.icon, this.label, this.screen);
}
