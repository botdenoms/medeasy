import 'package:flutter/material.dart';
import 'package:medeasy/widgets/widgets.dart';

import 'package:get/get.dart';
import '../model/models.dart';
import '../controllers/controllers.dart';

class MyScehdule extends StatefulWidget {
  const MyScehdule({super.key, required this.user});
  final User user;

  @override
  State<MyScehdule> createState() => _MyScehduleState();
}

class _MyScehduleState extends State<MyScehdule> {
  bool loading = true;
  List<Schedule> schedules = [];
  late String userId;

  mySchedules() async {
    final FireStoreController fireCon = Get.find();
    final UserController usr = Get.find();
    userId = usr.user()!.uid;
    final resp = await fireCon.getSchedulesOf(usr.user()!.uid);
    setState(() {
      schedules = resp!;
      loading = false;
    });
  }

  @override
  void initState() {
    mySchedules();
    super.initState();
  }

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
                        radius: 28, backgroundColor: Colors.amber),
                    Text(
                      widget.user.name,
                      style: const TextStyle(fontSize: 16),
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
            child: loading
                ? const Center(
                    child: LinearProgressIndicator(
                      color: Colors.greenAccent,
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (c, i) => ScheduleCard(
                      schedule: schedules[i],
                      id: userId,
                    ),
                    itemCount: schedules.length,
                  ),
          ),
        ],
      ),
    );
  }
}
