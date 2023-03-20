import 'package:flutter/material.dart';

class LogInWidget extends StatefulWidget {
  const LogInWidget({super.key});

  @override
  State<LogInWidget> createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogInWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
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
