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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF1E1E1E),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text('My schedule'),
              const SizedBox(height: 5),
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
                          const Text(
                            'Update',
                            style: TextStyle(fontSize: 17),
                          ),
                          const SizedBox(height: 5),
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
                          const Text(
                            'View',
                            style: TextStyle(fontSize: 17),
                          ),
                          const SizedBox(height: 5),
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
