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
          decoration: const InputDecoration(hintText: '[v]g/dl 13.5 - 17.5'),
          controller: widget.hermoglobin,
          onSubmitted: (value) => FocusScope.of(context).unfocus(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
        TextField(
          decoration:
              const InputDecoration(hintText: '[v]x10^3/uL   4.5 - 11.0'),
          controller: widget.wbc,
          onSubmitted: (value) => FocusScope.of(context).unfocus(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
        TextField(
          decoration:
              const InputDecoration(hintText: '[v]x10^6/uL   150 - 450'),
          controller: widget.rbc,
          onSubmitted: (value) => FocusScope.of(context).unfocus(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
        TextField(
          decoration:
              const InputDecoration(hintText: '[v]x10^3/uL   4.5 - 11.0'),
          controller: widget.platelets,
          onSubmitted: (value) => FocusScope.of(context).unfocus(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
        TextField(
          decoration: const InputDecoration(
              hintText: '[v] mg/dL <200  LDL<100  HDL>60'),
          controller: widget.cholesterol,
          onSubmitted: (value) => FocusScope.of(context).unfocus(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
        TextField(
          decoration: const InputDecoration(hintText: '[v] mg/dL <150'),
          controller: widget.triglycerides,
          onSubmitted: (value) => FocusScope.of(context).unfocus(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
        TextField(
          decoration: const InputDecoration(hintText: '[v] mg/dL 70 - 100 '),
          controller: widget.glucoseF,
          onSubmitted: (value) => FocusScope.of(context).unfocus(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
        TextField(
          decoration: const InputDecoration(hintText: '[v] mg/dL 70 - 140'),
          controller: widget.glucoseP,
          onSubmitted: (value) => FocusScope.of(context).unfocus(),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
      ],
    );
  }
}
