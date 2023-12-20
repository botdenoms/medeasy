import 'package:flutter/material.dart';

import '../model/models.dart';

class BloodData extends StatefulWidget {
  const BloodData({super.key, required this.bloodTest});
  final BloodTest bloodTest;

  @override
  State<BloodData> createState() => _BloodDataState();
}

class _BloodDataState extends State<BloodData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hermoglobin: ${widget.bloodTest.hermoglobin} g/dl (13.5 - 17.5)'),
        const SizedBox(height: 5),
        Text('WBC: ${widget.bloodTest.wbc} x10^3/uL (4.5 - 11.0)'),
        const SizedBox(height: 5),
        Text('RBC: ${widget.bloodTest.rbc} x10^6/uL (150 - 450)'),
        const SizedBox(height: 5),
        Text('Platelets: ${widget.bloodTest.platelets} x10^3/uL (4.5 - 11.0)'),
        const SizedBox(height: 5),
        Text(
            'Cholesterol: ${widget.bloodTest.cholesterol} mg/dL <200 LDL<100 HDL>60'),
        const SizedBox(height: 5),
        Text('Triglycerides: ${widget.bloodTest.triglycerides} mg/dL <150'),
        const SizedBox(height: 5),
        Text('Glucose F: ${widget.bloodTest.glucoseF} mg/dL (70 - 100)'),
        Text('Glucose P: ${widget.bloodTest.glucoseP} mg/dL (70 - 140)'),
      ],
    );
  }
}
