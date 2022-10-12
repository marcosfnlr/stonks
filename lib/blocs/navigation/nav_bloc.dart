import 'package:flutter_bloc/flutter_bloc.dart';

import 'nav_state.dart';

abstract class NavEvent {
  const NavEvent();
}

class ScreenSelected extends NavEvent {
  final int selectedIndex;
  const ScreenSelected({required this.selectedIndex});
}

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(NavState.home) {
    on<ScreenSelected>(_onScreenSelected);
  }

  Future<void> _onScreenSelected(
    ScreenSelected event,
    Emitter<NavState> emit,
  ) async {
    emit(NavState.values[event.selectedIndex]);
  }
}
