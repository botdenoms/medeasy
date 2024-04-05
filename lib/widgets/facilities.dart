import 'package:flutter/material.dart';

import '../model/models.dart';
import '../widgets/widgets.dart';

class Facilities extends StatefulWidget {
  const Facilities({super.key, required this.user});

  final User user;

  @override
  State<Facilities> createState() => _FacilitiesState();
}

class _FacilitiesState extends State<Facilities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 28,
                    child: Icon(
                      Icons.account_circle_outlined,
                    ),
                  ),
                  Text(
                    widget.user.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              UserStatus(user: widget.user, type: 1),
            ],
          ),
        ),
      ),
    );
  }
}
