import 'package:flutter/material.dart';

class PatientInforForm extends StatefulWidget {
  const PatientInforForm({
    super.key,
    required this.name,
    required this.gender,
    required this.dob,
  });
  final TextEditingController name;
  final TextEditingController gender;
  final TextEditingController dob;

  @override
  State<PatientInforForm> createState() => _PatientInforFormState();
}

class _PatientInforFormState extends State<PatientInforForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(hintText: 'Name Second'),
          controller: widget.name,
          onSubmitted: (value) => FocusScope.of(context).unfocus(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
        TextField(
          decoration: const InputDecoration(hintText: 'male = 1, female = 0'),
          controller: widget.gender,
          onSubmitted: (value) => FocusScope.of(context).unfocus(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
        TextField(
          decoration: const InputDecoration(hintText: 'mm/dd/yyyy'),
          controller: widget.dob,
          onSubmitted: (value) => FocusScope.of(context).unfocus(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
      ],
    );
  }
}
