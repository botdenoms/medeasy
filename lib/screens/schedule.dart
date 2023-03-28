import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key, required this.date});
  final DateTime date;

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(height: 20),
              const Text(
                'Schedule Setup',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 10),
              Text(
                formatDate(widget.date),
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 20),
              const Text(
                'type',
                style: TextStyle(fontSize: 11),
              ),
              const SizedBox(height: 10),
              Container(
                height: 40,
                width: double.infinity,
                color: Colors.greenAccent,
                child: const Center(
                  child: Text(
                    'Physical',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Time',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Icon(Icons.timer_outlined),
                  Text(
                    '14:05 PM',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Request',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDate(DateTime dt) {
    String day = '';
    String month = '';
    switch (dt.day) {
      case 1:
        day = '1st';
        break;
      case 2:
        day = '2nd';
        break;
      case 3:
        day = '3rd';
        break;
      default:
        day = '${dt.day}th';
    }
    switch (dt.month) {
      case 0:
        month = 'January';
        break;
      case 1:
        month = 'February';
        break;
      case 2:
        month = 'March';
        break;
      case 3:
        month = 'April';
        break;
      case 4:
        month = 'May';
        break;
      case 5:
        month = 'June';
        break;
      case 6:
        month = 'July';
        break;
      case 7:
        month = 'August';
        break;
      case 8:
        month = 'September';
        break;
      case 9:
        month = 'Octorber';
        break;
      case 10:
        month = 'November';
        break;
      case 11:
        month = 'December';
        break;
      default:
        break;
    }
    return 'On $day $month,${dt.year}';
  }
}
