import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({
    super.key,
    required this.name,
    required this.password,
    required this.email,
    required this.telephone,
  });

  final TextEditingController name;
  final TextEditingController password;
  final TextEditingController email;
  final TextEditingController telephone;

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.name,
          decoration: const InputDecoration(hintText: 'Name'),
        ),
        TextField(
          controller: widget.telephone,
          decoration: const InputDecoration(hintText: '07...'),
        ),
        TextField(
          controller: widget.email,
          decoration: const InputDecoration(hintText: 'Email@sm.com'),
        ),
        TextField(
          controller: widget.password,
          decoration: const InputDecoration(hintText: 'password'),
        ),
      ],
    );
  }
}
