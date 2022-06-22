import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'app_screen.dart';
import 'user.dart';
import 'inprogress_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _invalidLogin = false;
  String _invalidMessage = 'Failed';
  bool _inprogress = false;
  bool _serverError = false;

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final ColorScheme _colorScheme = const ColorScheme(
    primary: Color(0xffFA58B6),
    surface: Color(0xff7A0BC0),
    background: Color(0xff270082),
    secondary: Color(0xff1A1A40),
    error: Color.fromARGB(255, 255, 0, 221),
    onPrimary: Color(0xff000000),
    onSecondary: Color(0xff000000),
    onSurface: Color(0xffffffff),
    onBackground: Color(0xffffffff),
    onError: Color(0xffffffff),
    brightness: Brightness.dark,
  );

  bool validateLogin() {
    return _loginController.text != 'a' || _passController.text != 'a';
  }

  void _onLoginPressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _invalidLogin = false;
        _inprogress = true;
      });
      http
          .post(
            Uri.parse('http://localhost:5000/auth/login'),
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
    return Scaffold(
      backgroundColor: _colorScheme.background,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Center(
          child: Theme(
            data: ThemeData(colorScheme: _colorScheme),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  _logo(),
                  if (_invalidLogin)
                    Text(_invalidMessage,
                        style: TextStyle(
                          color: _colorScheme.onError,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center),
                  _form(),
                ],
              ),
            ),
          ),
        ),
        if (_inprogress) const InprogressIndicator(),
      ],
    );
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _loginController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'example@...',
              labelText: 'Email',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please, enter your email';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.password),
              hintText: '********',
              labelText: 'Password',
            ),
            controller: _passController,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please, enter your password';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton.icon(
              onPressed: _onLoginPressed,
              icon: const Text('Invest'),
              label: const Icon(Icons.login),
            ),
          ),
        ],
      ),
    );
  }

  Widget _logo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 7.0, color: _colorScheme.primary),
              bottom: BorderSide(width: 7.0, color: _colorScheme.primary),
            ),
          ),
          child: Icon(
            Icons.trending_up,
            color: _colorScheme.primary,
            size: 100.0,
            semanticLabel: 'Stonks Logo',
          ),
        ),
      ],
    );
  }
}
