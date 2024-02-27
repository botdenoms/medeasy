import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';
import '../model/models.dart';
import 'widgets.dart';

class Alerts extends StatefulWidget {
  const Alerts({super.key, required this.user});
  final User user;

  @override
  State<Alerts> createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
  bool loading = true;
  String? userId;
  List<Schedule> schedules = [];
  List<Diagnosis> diagnosis = [];

  notifications() async {
    final FireStoreController fireCon = Get.find();
    final UserController usr = Get.find();
    String usrId = usr.user()!.uid;
    final schdls = await fireCon.getSchedulesOf(usrId);
    // final dgs = await fireCon.getDiagnosisOf(usrId);
    setState(() {
      // diagnosis = dgs!;
      schedules = schdls!;
      userId = usrId;
      loading = false;
    });
    // List<Schedule> tmp = [];
    // if (dgs!.isEmpty) {
    //   setState(() {
    //     diagnosis = dgs;
    //     schedules = schdls!;
    //     userId = usrId;
    //     loading = false;
    //   });
    // } else {
    //   List<String> ids = [];
    //   for (Diagnosis el in dgs) {
    //     ids.add(el.schedule);
    //   }
    //   for (Schedule sch in schdls!) {
    //     if (ids.contains(sch.id!)) {
    //       // filter out
    //     } else {
    //       tmp.add(sch);
    //     }
    //   }
    //   setState(() {
    //     diagnosis = dgs;
    //     schedules = tmp;
    //     userId = usrId;
    //     loading = false;
    //   });
    // }
  }

  @override
  void initState() {
    notifications();
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
                    itemBuilder: (c, i) => NotificationCard(
                      schedule: schedules[i],
                      id: userId!,
                    ),
                    itemCount: schedules.length,
                  ),
          ),
        ],
      ),
    );
  }
}
