import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';
import '../model/models.dart';
import '../screens/screens.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({
    super.key,
    required this.schedule,
    required this.id,
  });
  final Schedule schedule;
  final String id;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool view = false;
  Specialist? specialist;
  User? patient;
  bool ready = false;
  bool running = true;
  Diagnosis? diagnosis;

  @override
  void initState() {
    initCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x22000000),
            spreadRadius: 2,
            blurRadius: 1,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.schedule.from
                .toString()
                .substring(0, widget.schedule.from.toString().length - 7),
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(height: 5),
          Text(
            duration(widget.schedule.from, widget.schedule.to),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            'Tests Attached: ${widget.schedule.tests!.length}',
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(height: 5),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => ScheduleViewDetails(
                    schedule: widget.schedule,
                  ),
                ),
              );
            },
            child: const Text(
              "Details",
              style: TextStyle(fontSize: 17),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              view
                  ? Text(
                      widget.id == widget.schedule.patient
                          ? "${specialist!.name} \n ${specialist!.speciality}"
                          : patient!.name,
                      style: const TextStyle(fontSize: 17),
                    )
                  : TextButton(
                      onPressed: () async {
                        if (widget.id == widget.schedule.patient) {
                          final usr =
                              await getSpecialist(widget.schedule.specialist);
                          setState(() {
                            specialist = usr;
                            view = true;
                          });
                        } else {
                          final usr = await getPatient(widget.schedule.patient);
                          setState(() {
                            patient = usr;
                            view = true;
                          });
                        }
                      },
                      child: Text(
                        widget.id == widget.schedule.patient
                            ? 'Specialist'
                            : "Patient",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
            ],
          ),
          const SizedBox(height: 5),
          running
              ? const CircularProgressIndicator()
              : TextButton(
                  onPressed: () {
                    if (widget.id == widget.schedule.patient) {
                      if (ready) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => DiagnosisView(
                              diagnosis: diagnosis!,
                            ),
                          ),
                        );
                      } else {
                        Get.snackbar(
                          'Notice',
                          'Diagnosis Pending \n awaiting specialist feedback',
                          backgroundColor: Colors.red,
                        );
                      }
                    } else {
                      if (ready) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => DiagnosisView(
                              diagnosis: diagnosis!,
                            ),
                          ),
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => DiagnosisScreen(
                              schedule: widget.schedule,
                            ),
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    widget.id == widget.schedule.patient
                        ? "Diagnosis"
                        : "Diagnose",
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
        ],
      ),
    );
  }

  Future<Diagnosis?> getDiagnosis(String id) async {
    final FireStoreController firecon = Get.find<FireStoreController>();
    return await firecon.getDiagnosisByScheduleId(id);
  }

  initCard() async {
    final FireStoreController firecon = Get.find<FireStoreController>();
    final resp = await firecon.getDiagnosisByScheduleId(widget.schedule.id!);
    if (resp != null) {
      setState(() {
        diagnosis = resp;
        ready = true;
        running = false;
      });
    } else {
      setState(() {
        ready = false;
        running = false;
      });
    }
  }

  String duration(DateTime f, DateTime t) {
    Duration df = t.difference(f);
    if (df.inHours < 1) {
      return '${df.inMinutes} mins';
    }
    return '${df.inHours} hrs';
  }

  Future<User?> getPatient(String id) async {
    final FireStoreController firecon = Get.find<FireStoreController>();
    return await firecon.userData(id);
  }

  Future<Specialist?> getSpecialist(String id) async {
    final FireStoreController firecon = Get.find<FireStoreController>();
    return await firecon.specialistData(id);
  }
}
