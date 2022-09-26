import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/login/login_bloc.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController _emailController;
  final TextEditingController _passController;
  final Key _formKey;

  const LoginForm({
    Key? key,
    required TextEditingController emailController,
    required TextEditingController passController,
    required Key formKey,
  })  : _emailController = emailController,
        _passController = passController,
        _formKey = formKey,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
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
              onPressed: () =>
                  BlocProvider.of<LoginBloc>(context).add(FormSubmit()),
              icon: const Text('Invest'),
              label: const Icon(Icons.login),
            ),
          ),
        ],
      ),
    );
  }
}
