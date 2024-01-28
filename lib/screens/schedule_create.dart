import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class ScheduleMgnt extends StatefulWidget {
  const ScheduleMgnt({super.key});

  @override
  State<ScheduleMgnt> createState() => _ScheduleMgntState();
}

class _ScheduleMgntState extends State<ScheduleMgnt> {
  bool viewer = false;
  bool dtSelected = false;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('My schedule'),
              Row(
                children: [
                  TextButton(
                      onPressed: () => {
                            setState(() {
                              viewer = !viewer;
                            })
                          },
                      child: Column(
                        children: [
                          const Text('Update'),
                          const SizedBox(height: 4),
                          Container(
                            color: viewer ? Colors.white : Colors.greenAccent,
                            height: 2,
                            width: 80,
                          ),
                        ],
                      )),
                  TextButton(
                      onPressed: () => {
                            setState(() {
                              viewer = !viewer;
                            })
                          },
                      child: Column(
                        children: [
                          const Text('View'),
                          const SizedBox(height: 4),
                          Container(
                            color: viewer ? Colors.greenAccent : Colors.white,
                            height: 2,
                            width: 80,
                          ),
                        ],
                      )),
                ],
              ),
              const SizedBox(height: 10),
              viewer ? const ScheduleViewer() : const ScheduleUpdater(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
