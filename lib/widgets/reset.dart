import 'package:flutter/material.dart';

class ResetWidget extends StatefulWidget {
  const ResetWidget({super.key, required this.email, required this.name});

  final TextEditingController email;
  final TextEditingController name;

  @override
  State<ResetWidget> createState() => _ResetWidgetState();
}

class _ResetWidgetState extends State<ResetWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.name,
          decoration: const InputDecoration(hintText: 'Name'),
        ),
        TextField(
          controller: widget.email,
          decoration: const InputDecoration(hintText: 'Email@sm.com'),
        ),
      ],
    );
  }
}
