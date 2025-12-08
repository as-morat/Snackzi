import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: .all(15), child: Column(
        children: [
          Image.asset("images/6343825.jpg", width: 500, fit: .cover,)
        ],
      )),
    );
  }
}
