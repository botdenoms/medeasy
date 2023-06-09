import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';

import './screens.dart';
import '../model/models.dart';

class SpecialistView extends StatefulWidget {
  const SpecialistView({super.key, required this.specialist});
  final Specialist specialist;

  @override
  State<SpecialistView> createState() => _SpecialistViewState();
}

class _SpecialistViewState extends State<SpecialistView> {
  DateTime? selectedDate;
  DateTime focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ClipOval(
                      child: SizedBox(
                        height: 56,
                        width: 56,
                        child: Image.network(
                          widget.specialist.profile,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      widget.specialist.verified ? 'Verified' : 'UnVerified',
                      style: TextStyle(
                          color: widget.specialist.verified
                              ? Colors.greenAccent
                              : Colors.redAccent,
                          fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(widget.specialist.name,
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.specialist.speciality,
                        style: const TextStyle(fontSize: 16)),
                    Text(
                      '${widget.specialist.location[1]}, ${widget.specialist.location[0]}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Calendar', style: TextStyle(fontSize: 14)),
                const SizedBox(height: 5),
                TableCalendar(
                  firstDay: DateTime.now().subtract(
                    const Duration(days: 1),
                  ),
                  lastDay: DateTime(2030),
                  focusedDay: focusedDate,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      selectedDate = selectedDay;
                      focusedDate = focusedDay;
                    });
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (BuildContext context) => Scheduler(
                        date: selectedDate!,
                        specialist: widget.specialist,
                      ),
                    ));
                  },
                  onPageChanged: (focusedDay) {
                    focusedDate = focusedDay;
                  },
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
