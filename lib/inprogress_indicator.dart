import 'package:flutter/material.dart';

class InprogressIndicator extends StatelessWidget {
  const InprogressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: const Color.fromARGB(100, 0, 0, 0),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
