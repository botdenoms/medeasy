import 'package:flutter/material.dart';
import 'package:medeasy/widgets/widgets.dart';

import '../model/models.dart';

class MySpecialist extends StatefulWidget {
  const MySpecialist({super.key, required this.user});
  final User user;
  @override
  State<MySpecialist> createState() => _MySpecialistState();
}

class _MySpecialistState extends State<MySpecialist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.amber,
                    ),
                    Text(
                      widget.user.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          UserStatus(user: widget.user),
        ],
      ),
    );
  }
}
