import 'package:flutter/material.dart';

class PatientData extends StatefulWidget {
  const PatientData({super.key, required this.name});
  final String name;

  @override
  State<PatientData> createState() => _PatientDataState();
}

class _PatientDataState extends State<PatientData> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.name);
  }
}
