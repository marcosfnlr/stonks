import 'package:flutter/material.dart';
// import 'package:our_structures/our_structures.dart';

import 'login_screen.dart';

void main() {
  runApp(const StonksApp());
}

class StonksApp extends StatelessWidget {
  const StonksApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(),
    );
  }
}
