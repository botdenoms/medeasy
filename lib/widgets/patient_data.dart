import 'package:flutter/material.dart';

class PatientData extends StatefulWidget {
  const PatientData({
    super.key,
    required this.name,
    required this.dob,
  });
  final String name;
  final DateTime dob;

  @override
  State<PatientData> createState() => _PatientDataState();
}

class _PatientDataState extends State<PatientData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          yrsString(widget.dob),
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  yrsString(DateTime dob) {
    final dur = DateTime.now().difference(dob);
    return '${(dur.inDays / 365).ceil()} yrs';
  }
}
