import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stonks/screens/login/login_form.dart';

import '../app_screen.dart';
import '../../components/inprogress_indicator.dart';
import '../../components/stonks_logo.dart';
import '../../models/spacing.dart';
import '../../models/user.dart';
import '../../themes/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _invalidLogin = false;
  String _invalidMessage = 'Failed';
  bool _inprogress = false;
  bool _serverError = false;

  void _onLoginPressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _invalidLogin = false;
        _inprogress = true;
      });
      http
          .post(
            Uri.parse('http://localhost:3000/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'email': _loginController.text,
              'password': _passController.text,
            }),
          )
          .then(_loginResponse);
    }
  }

  void _loginResponse(response) async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _inprogress = false;
    });
    switch (response.statusCode) {
      case 200:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Screen(
              user: User.fromJson(jsonDecode(response.body)),
            ),
          ),
        );
        break;
      case 401:
        setState(() {
          _invalidLogin = true;
          _invalidMessage = jsonDecode(response.body)['message'];
        });
        break;
      default:
        setState(() {
          _serverError = true;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Style.loginThemeData();
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Stack(
        children: [
          Center(
            child: Theme(
              data: theme,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    StonksLogo(color: theme.colorScheme.primary, size: 100),
                    const SizedBox(height: Spacing.large),
                    if (_invalidLogin)
                      Text(_invalidMessage,
                          style: TextStyle(
                            color: theme.colorScheme.onError,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center),
                    LoginForm(
                      emailController: _loginController,
                      passController: _passController,
                      formKey: _formKey,
                      onLoginPressed: _onLoginPressed,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_inprogress) const InprogressIndicator(),
        ],
      ),
    );
  }
}
