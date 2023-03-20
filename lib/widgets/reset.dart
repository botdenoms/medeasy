import 'package:flutter/material.dart';

class ResetWidget extends StatefulWidget {
  const ResetWidget({super.key});

  @override
  State<ResetWidget> createState() => _ResetWidgetState();
}

class _ResetWidgetState extends State<ResetWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TextField(
          decoration: InputDecoration(hintText: 'Name'),
        ),
        TextField(
          decoration: InputDecoration(hintText: 'Email@sm.com'),
        ),
      ],
    );
  }
}
