import 'package:flutter/material.dart';

import '../model/models.dart';
import '../screens/screens.dart';

class Tests extends StatefulWidget {
  const Tests({super.key, required this.user});

  final User user;

  @override
  State<Tests> createState() => _TestsState();
}

class _TestsState extends State<Tests> {
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text("Take a Test \n find facilities within the app"),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const Facilities(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
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
                        child: const Text('Find Facilities'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'My tests',
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
