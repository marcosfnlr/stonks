import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController _emailController;
  final TextEditingController _passController;
  final Key _formKey;
  final void Function() _onLoginPressed;

  const LoginForm({
    Key? key,
    required TextEditingController emailController,
    required TextEditingController passController,
    required Key formKey,
    required void Function() onLoginPressed,
  })  : _emailController = emailController,
        _passController = passController,
        _formKey = formKey,
        _onLoginPressed = onLoginPressed,
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
              onPressed: _onLoginPressed,
              icon: const Text('Invest'),
              label: const Icon(Icons.login),
            ),
          ),
        ],
      ),
    );
  }
}
