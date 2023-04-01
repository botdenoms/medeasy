import 'package:flutter/material.dart';

class LogInWidget extends StatefulWidget {
  const LogInWidget({super.key, required this.email, required this.password});

  final TextEditingController email;
  final TextEditingController password;

  @override
  State<LogInWidget> createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogInWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.email,
          decoration: const InputDecoration(hintText: 'Email@sm.com'),
          keyboardType: TextInputType.emailAddress,
        ),
        TextField(
          controller: widget.password,
          decoration: const InputDecoration(hintText: 'password'),
          obscureText: true,
        ),
      ],
    );
  }
}
