import 'package:flutter/material.dart';

import '../model/models.dart';
import 'widgets.dart';

class UserStatus extends StatefulWidget {
  const UserStatus({super.key, required this.user});
  final User user;

  @override
  State<UserStatus> createState() => _UserStatusState();
}

class _UserStatusState extends State<UserStatus> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: StatsCard(specialist: widget.user.specialist!),
          ),
          const SizedBox(height: 20),
          Expanded(child: AccountOpts(user: widget.user)),
        ],
      ),
    );
  }
}
