import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/user.dart';

abstract class UserDataEvent {}

class UserDataState {
  final User user;
  const UserDataState({required this.user});
}

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  UserDataBloc({required User user}) : super(UserDataState(user: user));
}
