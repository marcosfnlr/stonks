import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PanelExpansionEvent {}

class ExpansionToggled extends PanelExpansionEvent {}

class PanelExpansionBloc extends Bloc<PanelExpansionEvent, bool> {
  PanelExpansionBloc({isExpanded = true}) : super(isExpanded) {
    on<ExpansionToggled>(((event, emit) => emit(!state)));
  }
}
