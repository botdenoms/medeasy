import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medeasy/model/models.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controllers/controllers.dart';

class ScheduleUpdater extends StatefulWidget {
  const ScheduleUpdater({super.key});

  @override
  State<ScheduleUpdater> createState() => _ScheduleUpdaterState();
}

class _ScheduleUpdaterState extends State<ScheduleUpdater> {
  bool manual = true;
  bool dtPicked = false;
  bool running = false;
  DateTime? selectedDate;
  DateTime focusedDate = DateTime.now();
  TimeOfDay? from;
  TimeOfDay? to;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  manual = !manual;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: manual ? Colors.blueAccent : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Manual',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  manual = !manual;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: manual ? Colors.white : Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Auto',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        manual
            ? dtPicked
                ? Row(
                    children: [
                      Text(
                        dateString(selectedDate),
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            dtPicked = !dtPicked;
                          });
                        },
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.redAccent,
                        ),
                      )
                    ],
                  )
                : TableCalendar(
                    firstDay: DateTime.now().subtract(
                      const Duration(days: 1),
                    ),
                    lastDay: DateTime(2030),
                    focusedDay: focusedDate,
                    currentDay: selectedDate,
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        selectedDate = selectedDay;
                        dtPicked = !dtPicked;
                        focusedDate = selectedDay;
                      });
                    },
                    onPageChanged: (focusedDay) {
                      // focusedDate = focusedDay;
                    },
                  )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text("PDF"),
                  Text("XML"),
                  Text("CSV"),
                  Text('Google Calendar')
                ],
              ),
        manual
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'From',
                        style: TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () async {
                          final frm = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          if (frm != null) {
                            setState(() {
                              from = frm;
                            });
                          }
                        },
                        child: Text(
                          timeString(from),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'To',
                        style: TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () async {
                          final t = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          if (t != null) {
                            setState(() {
                              to = t;
                            });
                          }
                        },
                        child: Text(
                          timeString(to),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : const SizedBox(),
        const SizedBox(height: 10),
        running
            ? const CircularProgressIndicator()
            : TextButton(
                onPressed: () => {updateHandler()},
                child: const Text('update'),
              )
      ],
    );
  }

  scheduleCreate(DateTime? onday, TimeOfDay? from, TimeOfDay? to) async {
    if (onday == null || from == null || to == null) {
      return;
    }
    setState(() {
      running = true;
    });
    final UserController userCon = Get.find();
    TimeTable tmtb = TimeTable(
      start: from,
      finish: to,
      day: onday,
      user: userCon.user()!.uid,
    );
    final FireStoreController fireCon = Get.find();
    final resp = await fireCon.createTimeTable(tmtb);
    if (resp) {
      Get.snackbar(
        'Success',
        'Schedule successfully Created',
        backgroundColor: Colors.greenAccent,
      );
      setState(() {
        running = false;
      });
    } else {
      Get.snackbar(
        'Error',
        'Failded to create your schedule\n try again',
        backgroundColor: Colors.redAccent,
      );
      setState(() {
        running = false;
      });
    }
  }

  String dateString(DateTime? dt) {
    if (dt == null) {
      return "00/00/0000";
    }
    var mnt = dt.month.toString().padLeft(2, '0');
    var dy = dt.day.toString().padLeft(2, '0');
    var yr = dt.year;
    return "$mnt/$dy/$yr";
  }

  updateHandler() {
    if (!manual) {
      Get.snackbar("Note", 'To be implemented');
      return;
    }
    if (selectedDate == null || to == null || from == null) {
      Get.snackbar("Error", 'message');
    } else {
      scheduleCreate(
        selectedDate,
        from,
        to,
      );
    }
  }

  String timeString(TimeOfDay? tm) {
    if (tm == null) {
      return "00:00";
    }
    var hrs = tm.hour.toString().padLeft(2, '0');
    var mns = tm.minute.toString().padLeft(2, '0');
    return "$hrs:$mns";
  }
}
