import 'package:flutter/material.dart';

import '../models/nav_option.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key, required this.selectedOption, required this.onTap})
      : super(key: key);

  final NavigationOption selectedOption;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedOption.index,
      onTap: onTap,
      items: NavigationOption.values
          .map(
            (opt) => BottomNavigationBarItem(
              icon: opt.icon,
              label: opt.label,
              backgroundColor: opt.colors.primary,
            ),
          )
          .toList(),
    );
  }
}
