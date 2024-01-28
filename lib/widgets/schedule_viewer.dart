import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controllers/controllers.dart';
import '../model/models.dart';

class ScheduleViewer extends StatefulWidget {
  const ScheduleViewer({super.key});

  @override
  State<ScheduleViewer> createState() => _ScheduleViewerState();
}

class _ScheduleViewerState extends State<ScheduleViewer> {
  DateTime? selectedDate;
  DateTime focusedDate = DateTime.now();
  bool fetching = false;
  List<TimeTable> schedule = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.now().subtract(
            const Duration(days: 1),
          ),
          lastDay: DateTime(2030),
          focusedDay: focusedDate,
          currentDay: selectedDate,
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              selectedDate = selectedDay;
              focusedDate = selectedDay;
            });
            fetchSchedule(selectedDate);
          },
          onPageChanged: (focusedDay) {
            // focusedDate = focusedDay;
          },
        ),
        const SizedBox(height: 10),
        fetching
            ? const CircularProgressIndicator()
            : Text(
                'Activity items: ${schedule.length}',
              )
      ],
    );
  }

  fetchSchedule(DateTime? dt) async {
    setState(() {
      fetching = true;
    });
    // await Future.delayed(const Duration(seconds: 3));
    final FireStoreController fireCon = Get.find();
    final UserController userCon = Get.find();
    final results =
        await fireCon.getTimeTable(userCon.user()!.uid, selectedDate!);
    setState(() {
      schedule = results!;
      fetching = false;
    });
  }
}
