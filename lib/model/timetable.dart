import 'package:flutter/material.dart';

class TimeTable {
  final TimeOfDay start;
  final TimeOfDay finish;
  final DateTime day;
  final String user;
  bool available;
  String? id;

  TimeTable({
    required this.start,
    required this.finish,
    required this.day,
    required this.user,
    required this.available,
    this.id,
  });

  Map<String, dynamic> toMap() {
    DateTime st = day.copyWith(
      hour: start.hour,
      minute: start.minute,
      second: 0,
    );
    DateTime en = day.copyWith(
      hour: finish.hour,
      minute: finish.minute,
      second: 0,
    );
    return {
      'start': st,
      'finish': en,
      'day': day,
      'user': user,
      'available': available,
    };
  }
}
