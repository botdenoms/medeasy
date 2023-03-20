import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TextField(
          decoration: InputDecoration(hintText: 'Name'),
        ),
        TextField(
          decoration: InputDecoration(hintText: '07...'),
        ),
        TextField(
          decoration: InputDecoration(hintText: 'Email@sm.com'),
        ),
        TextField(
          decoration: InputDecoration(hintText: 'password'),
        ),
      ],
    );
  }
}
