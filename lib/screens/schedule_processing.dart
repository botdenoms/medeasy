import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';
import '../model/models.dart';
import '../widgets/widgets.dart';

class ScheduleMng extends StatefulWidget {
  const ScheduleMng({super.key, required this.schedule});
  final List<Schedule> schedule;

  @override
  State<ScheduleMng> createState() => _ScheduleMngState();
}

class _ScheduleMngState extends State<ScheduleMng> {
  String? userId;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Your Schedules',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemBuilder: (c, i) => ScheduleCard(
                schedule: widget.schedule[i],
                id: userId!,
              ),
              itemCount: widget.schedule.length,
            ),
          ),
        ],
      ),
    );
  }

  getUser() async {
    final UserController usr = Get.find();
    final s = usr.user()!.uid;
    setState(() {
      userId = s;
    });
  }
}
