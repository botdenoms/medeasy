import 'package:flutter/material.dart';

class TimeTable {
  final TimeOfDay start;
  final TimeOfDay finish;
  final DateTime day;
  final String user;

  TimeTable({
    required this.start,
    required this.finish,
    required this.day,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    DateTime st = day.copyWith(
      hour: start.hour,
      minute: start.minute,
    );
    DateTime en = day.copyWith(
      hour: finish.hour,
      minute: finish.minute,
    );
    return {
      'start': st,
      'finish': en,
      'day': day,
      'user': user,
    };
  }
}
