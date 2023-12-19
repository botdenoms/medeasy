import 'package:flutter/material.dart';

import '../model/models.dart';

class FaciltySchedule extends StatefulWidget {
  const FaciltySchedule({
    super.key,
    required this.facility,
  });
  final Facility facility;

  @override
  State<FaciltySchedule> createState() => _FaciltyScheduleState();
}

class _FaciltyScheduleState extends State<FaciltySchedule> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
