import 'package:flutter/material.dart';

enum NavigationOption {
  dummy,
  home,
  stocks,
  profile,
}

extension NavigationOptionExtension on NavigationOption {
  Icon get icon {
    switch (this) {
      case NavigationOption.home:
        return const Icon(Icons.home);
      case NavigationOption.stocks:
        return const Icon(Icons.trending_up);
      case NavigationOption.profile:
        return const Icon(Icons.person);
      case NavigationOption.dummy:
        return const Icon(Icons.sports_volleyball);
    }
  }

  String get label {
    switch (this) {
      case NavigationOption.home:
        return 'Home';
      case NavigationOption.stocks:
        return 'Stocks';
      case NavigationOption.profile:
        return 'Profile';
      case NavigationOption.dummy:
        return 'Volley';
    }
  }
}
