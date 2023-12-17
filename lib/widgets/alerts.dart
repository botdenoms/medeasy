import 'package:flutter/material.dart';

import '../model/user.dart';

class Alerts extends StatefulWidget {
  const Alerts({super.key, required this.user});

  final User user;

  @override
  State<Alerts> createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
  bool loading = true;
  List<String> schedules = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
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
                const SizedBox(height: 10),
                const Text(
                  'My alerts',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: loading
                ? const Center(
                    child: LinearProgressIndicator(
                      color: Colors.greenAccent,
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (c, i) => const Placeholder(),
                    itemCount: schedules.length,
                  ),
          ),
        ],
      ),
    );
  }
}
