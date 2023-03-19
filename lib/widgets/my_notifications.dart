import 'package:flutter/material.dart';
import 'package:medeasy/widgets/widgets.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({super.key});

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {
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
                  children: const [
                    CircleAvatar(radius: 28, backgroundColor: Colors.amber),
                    Text(
                      'User Name',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'My notifications',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Filter by: ',
                  style: TextStyle(fontSize: 14, color: Colors.greenAccent),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                ScheduleCard(),
                ScheduleCard(),
                ScheduleCard(),
                ScheduleCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
