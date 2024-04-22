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
        const Text('Hermoglobin', style: TextStyle(fontSize: 11)),
        const SizedBox(height: 2),
        Text(
          '${widget.bloodTest.hermoglobin}    g/dl (13.5 - 17.5)',
          style: const TextStyle(fontSize: 17),
        ),
        const SizedBox(height: 10),
        const Text('WBC', style: TextStyle(fontSize: 11)),
        const SizedBox(height: 2),
        Text(
          '${widget.bloodTest.wbc}    x10^3/uL (4.5 - 11.0)',
          style: const TextStyle(fontSize: 17),
        ),
        const SizedBox(height: 10),
        const Text('RBC', style: TextStyle(fontSize: 11)),
        const SizedBox(height: 2),
        Text(
          '${widget.bloodTest.rbc}    x10^6/uL (150 - 450)',
          style: const TextStyle(fontSize: 17),
        ),
        const SizedBox(height: 10),
        const Text('Platelets', style: TextStyle(fontSize: 11)),
        const SizedBox(height: 2),
        Text(
          '${widget.bloodTest.platelets}    x10^3/uL (4.5 - 11.0)',
          style: const TextStyle(fontSize: 17),
        ),
        const SizedBox(height: 10),
        const Text('Cholesterol', style: TextStyle(fontSize: 11)),
        const SizedBox(height: 2),
        Text(
          '${widget.bloodTest.cholesterol}    mg/dL <200 LDL<100 HDL>60',
          style: const TextStyle(fontSize: 17),
        ),
        const SizedBox(height: 10),
        const Text('Triglycerides', style: TextStyle(fontSize: 11)),
        const SizedBox(height: 2),
        Text(
          '${widget.bloodTest.triglycerides}    mg/dL <150',
          style: const TextStyle(fontSize: 17),
        ),
        const SizedBox(height: 10),
        const Text('Glucose F', style: TextStyle(fontSize: 11)),
        const SizedBox(height: 2),
        Text(
          '${widget.bloodTest.glucoseF}    mg/dL (70 - 100)',
          style: const TextStyle(fontSize: 17),
        ),
        const SizedBox(height: 10),
        const Text('Glucose P', style: TextStyle(fontSize: 11)),
        const SizedBox(height: 2),
        Text(
          '${widget.bloodTest.glucoseP}    mg/dL (70 - 140)',
          style: const TextStyle(fontSize: 17),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
