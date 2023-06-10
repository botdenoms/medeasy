import 'package:flutter/material.dart';

import '../model/models.dart';
import '../screens/screens.dart';

class AccountOpts extends StatefulWidget {
  const AccountOpts({super.key, required this.user});
  final User user;

  @override
  State<AccountOpts> createState() => _AccountOptsState();
}

class _AccountOptsState extends State<AccountOpts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          widget.user.specialist == true
              ? 'Remove your specialist'
              : 'Create a specialist',
          style: const TextStyle(fontSize: 15),
        ),
        const Text(
          'account',
          style: TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                actionHandler();
              },
              child: Container(
                padding: const EdgeInsets.all(
                  10.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      spreadRadius: 2,
                      blurRadius: 1,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    widget.user.specialist == true ? 'UnRegister' : 'Register',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  actionHandler() async {
    if (widget.user.specialist == true) {
      // Un registering action
      return;
    }
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => Registration(
          name: widget.user.name,
        ),
      ),
    );
    setState(() {});
  }
}
