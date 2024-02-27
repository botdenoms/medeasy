import 'package:flutter/material.dart';

import '../model/models.dart';

class DiagnosisView extends StatefulWidget {
  const DiagnosisView({
    super.key,
    required this.diagnosis,
  });
  final Diagnosis diagnosis;

  @override
  State<DiagnosisView> createState() => _DiagnosisViewState();
}

class _DiagnosisViewState extends State<DiagnosisView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
