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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF1E1E1E),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                formatDate(widget.diagnosis.date),
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 10),
              Text(
                widget.diagnosis.findings,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Divider(),
              Text(
                widget.diagnosis.recommends,
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 5),
              const Text(
                'Prescriptions',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 5),
              ...prescTxts(widget.diagnosis.prescripts),
              const SizedBox(height: 5),
              const Divider(),
              TextButton(
                onPressed: () {
                  // submitDiagnosis();
                },
                child: const Text(
                  "Specialist",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              TextButton(
                onPressed: () {
                  // submitDiagnosis();
                },
                child: const Text(
                  "Patient",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> prescTxts(List<String> prescpts) {
    List<Widget> wdgts = [];
    if (prescpts.isEmpty) {
      return wdgts;
    }
    int c = 1;
    for (String tt in prescpts) {
      final tc = Text('$c. $tt');
      wdgts.add(tc);
      c += 1;
    }
    return wdgts;
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
      case 1:
        month = 'January';
        break;
      case 2:
        month = 'February';
        break;
      case 3:
        month = 'March';
        break;
      case 4:
        month = 'April';
        break;
      case 5:
        month = 'May';
        break;
      case 6:
        month = 'June';
        break;
      case 7:
        month = 'July';
        break;
      case 8:
        month = 'August';
        break;
      case 9:
        month = 'September';
        break;
      case 10:
        month = 'Octorber';
        break;
      case 11:
        month = 'November';
        break;
      case 12:
        month = 'December';
        break;
      default:
        break;
    }
    return '$day $month, ${dt.year}';
  }
}
