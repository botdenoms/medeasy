import 'package:flutter/material.dart';

import '../model/models.dart';
import 'widgets.dart';

class UserStatus extends StatefulWidget {
  const UserStatus({super.key, required this.user, required this.type});
  final User user;
  final int type;

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
            child: widget.type == 0
                ? StatsCard(specialist: widget.user.specialist!)
                : FacilityStatus(specialist: widget.user.specialist!),
          ),
          const SizedBox(height: 20),
          widget.type == 0
              ? Expanded(child: AccountOpts(user: widget.user))
              : Expanded(child: FacilityOpts(user: widget.user)),
        ],
      ),
    );
  }
}
