import 'package:flutter/material.dart';

import '/screens/login/login_screen.dart';

class LogoutAlert extends StatelessWidget {
  const LogoutAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('Sure you wanna leave us?'),
      actions: <Widget>[
        TextButton.icon(
          onPressed: () => Navigator.pop(context, true),
          icon: const Text('Stay'),
          label: const Icon(Icons.sentiment_very_satisfied),
        ),
        TextButton.icon(
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            ((_) => false),
          ),
          icon: const Text('Leave'),
          label: const Icon(Icons.heart_broken),
        ),
      ],
    );
  }
}
