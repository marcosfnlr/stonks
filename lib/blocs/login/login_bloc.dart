import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user.dart';
import '../../screens/app_screen.dart';
import 'login_state.dart';

abstract class LoginEvent {}

class FormSubmit extends LoginEvent {}

class LoginSucceed extends LoginEvent {}

class LoginFail extends LoginEvent {}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GlobalKey<FormState> _formKey;
  final TextEditingController _loginController;
  final TextEditingController _passController;
  final NavigatorState _navigator;

  LoginBloc({
    required GlobalKey<FormState> formKey,
    required TextEditingController loginController,
    required TextEditingController passController,
    required NavigatorState navigator,
  })  : _formKey = formKey,
        _loginController = loginController,
        _passController = passController,
        _navigator = navigator,
        super(LoginState.standard) {
    on<FormSubmit>(_onFormSubmit);
  }

  Future<void> _onFormSubmit(FormSubmit event, Emitter<LoginState> emit) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    emit(LoginState.waitingResponse);

    final response = await http.post(
      Uri.parse('http://localhost:3000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': _loginController.text,
        'password': _passController.text,
      }),
    );

    await Future.delayed(const Duration(seconds: 1));

    switch (response.statusCode) {
      case 200:
        _navigator.pushReplacement(
          MaterialPageRoute(
            builder: (context) => Screen(
              user: User.fromJson(jsonDecode(response.body)),
            ),
          ),
        );
        break;
      case 401:
        emit(LoginState.serverValidationFail(
          message: jsonDecode(response.body)['message'],
        ));
        break;
      default:
        emit(LoginState.errorWithMessage(
          message: jsonDecode(response.body)['message'],
        ));
    }
  }
}
