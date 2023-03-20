import 'package:flutter/material.dart';
import 'package:medeasy/widgets/widgets.dart';

class MyScehdule extends StatefulWidget {
  const MyScehdule({super.key});

  @override
  State<MyScehdule> createState() => _MyScehduleState();
}

class _MyScehduleState extends State<MyScehdule> {
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
                  'My schedules',
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
              children: const [ScheduleCard()],
            ),
          ),
        ],
      ),
    );
  }
}
