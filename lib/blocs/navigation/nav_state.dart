import 'package:flutter/material.dart';

enum NavState {
  dummy(icon: Icon(Icons.sports_volleyball), label: 'Volley'),
  home(icon: Icon(Icons.home), label: 'Home'),
  stocks(icon: Icon(Icons.trending_up), label: 'Stocks'),
  profile(icon: Icon(Icons.person), label: 'Profile');

  final Icon icon;
  final String label;
  const NavState({required this.icon, required this.label});
}
