import 'package:flutter/material.dart';

class BloodForm extends StatefulWidget {
  const BloodForm({
    super.key,
    required this.hermoglobin,
    required this.wbc,
    required this.rbc,
    required this.platelets,
    required this.cholesterol,
    required this.triglycerides,
    required this.glucoseF,
    required this.glucoseP,
  });

  final TextEditingController hermoglobin;
  final TextEditingController wbc;
  final TextEditingController rbc;
  final TextEditingController platelets;
  final TextEditingController cholesterol;
  final TextEditingController triglycerides;
  final TextEditingController glucoseF;
  final TextEditingController glucoseP;

  @override
  State<BloodForm> createState() => _BloodFormState();
}

class _BloodFormState extends State<BloodForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(hintText: 'Name Second'),
          controller: widget.hermoglobin,
          onSubmitted: (value) => FocusScope.of(context).unfocus(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
        TextField(
          decoration: const InputDecoration(hintText: 'male = 1, female = 0'),
          controller: widget.wbc,
          onSubmitted: (value) => FocusScope.of(context).unfocus(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
        TextField(
          decoration: const InputDecoration(hintText: 'mm/dd/yyyy'),
          controller: widget.rbc,
          onSubmitted: (value) => FocusScope.of(context).unfocus(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
        TextField(
          decoration: const InputDecoration(hintText: 'Name Second'),
          controller: widget.platelets,
          onSubmitted: (value) => FocusScope.of(context).unfocus(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
        TextField(
          decoration: const InputDecoration(hintText: 'male = 1, female = 0'),
          controller: widget.cholesterol,
          onSubmitted: (value) => FocusScope.of(context).unfocus(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
        TextField(
          decoration: const InputDecoration(hintText: 'mm/dd/yyyy'),
          controller: widget.triglycerides,
          onSubmitted: (value) => FocusScope.of(context).unfocus(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
        TextField(
          decoration: const InputDecoration(hintText: 'Name Second'),
          controller: widget.glucoseF,
          onSubmitted: (value) => FocusScope.of(context).unfocus(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
        TextField(
          decoration: const InputDecoration(hintText: 'male = 1, female = 0'),
          controller: widget.glucoseP,
          onSubmitted: (value) => FocusScope.of(context).unfocus(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
      ],
    );
  }
}
