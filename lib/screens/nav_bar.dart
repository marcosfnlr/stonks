import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/navigation/nav_bloc.dart';
import '../blocs/navigation/nav_state.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBloc, NavState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.index,
          onTap: (tappedIndex) => BlocProvider.of<NavBloc>(context)
              .add(ScreenSelected(selectedIndex: tappedIndex)),
          items: NavState.values
              .map(
                (state) => BottomNavigationBarItem(
                  icon: state.icon,
                  label: state.label,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              )
              .toList(),
        );
      },
    );
  }
}
