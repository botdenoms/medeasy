import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medeasy/model/models.dart';

import '../controllers/controllers.dart';

class ScheduleCard extends StatefulWidget {
  const ScheduleCard({super.key, required this.schedule, required this.id});
  final Schedule schedule;
  final String id;

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  User? patient;
  Specialist? specialist;
  bool view = false;

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
            widget.schedule.time
                .toString()
                .substring(0, widget.schedule.time.toString().length - 7),
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.schedule.online ? "Online" : " Physical",
                style: const TextStyle(fontSize: 17),
              ),
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
                            print("usr: ${usr}");
                            print("field: ${specialist}");
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SizedBox(width: 5),
              Icon(Icons.call, color: Colors.blueAccent, size: 24),
              Icon(Icons.whatsapp_rounded, color: Colors.greenAccent, size: 24),
              Icon(Icons.message_rounded, color: Colors.blueAccent, size: 24),
              SizedBox(width: 5),
            ],
          ),
          // added ratings when schedule is due
        ],
      ),
    );
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
