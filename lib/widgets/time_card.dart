import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/models.dart';

class TimeCard extends StatefulWidget {
  const TimeCard({super.key, required this.timeTable, required this.callBack});
  final TimeTable timeTable;
  final Function? callBack;

  @override
  State<TimeCard> createState() => _TimeCardState();
}

class _TimeCardState extends State<TimeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.timeTable.available ? Colors.greenAccent : Colors.redAccent,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          if (widget.timeTable.available) {
            if (widget.callBack != null) {
              widget.callBack!(
                widget.timeTable.start,
                widget.timeTable.finish,
              );
              Get.snackbar(
                'Notice',
                'Time updated',
                backgroundColor: Colors.blueAccent,
              );
            } else {
              Get.snackbar(
                'Error',
                'CallBack Function is null',
                backgroundColor: Colors.redAccent,
              );
            }
          } else {
            Get.snackbar(
              'Error',
              'Specialist is Busy at this time',
              backgroundColor: Colors.redAccent,
            );
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              timeString(widget.timeTable.start),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              timeString(widget.timeTable.finish),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.timeTable.available ? 'Available' : 'Occupied',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
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
