import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:medeasy/controllers/controllers.dart';
import 'package:medeasy/model/models.dart';

class RequestCard extends StatefulWidget {
  const RequestCard({
    super.key,
    required this.request,
    required this.specialist,
    required this.userId,
  });
  final Request request;
  final bool specialist;
  final String userId;

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  bool user = false;
  bool modTime = false;
  bool modDate = false;
  bool spinUsr = false;
  bool spinPros = false;
  User? patient;
  Specialist? specialist;
  TimeOfDay? time;
  DateTime? dt;
  bool closed = false;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // show date picker
                          datePick();
                        },
                        child: Text(
                          '${widget.request.time.day.toString().padLeft(2, '0')}/${widget.request.time.month.toString().padLeft(2, '0')}/${widget.request.time.year.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            fontSize: 17,
                            decoration: modDate
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                      modDate
                          ? Text(
                              " --> ${dt!.day.toString().padLeft(2, '0')}/${dt!.month.toString().padLeft(2, '0')}/${dt!.year.toString().padLeft(2, '0')}",
                              style: const TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          timePick();
                        },
                        child: Text(
                          '${widget.request.time.hour.toString().padLeft(2, '0')}:${widget.request.time.minute.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            fontSize: 17,
                            decoration: modTime
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                      modTime
                          ? Text(
                              ' --> ${time!.hour.toString().padLeft(2, '0')}:${time!.minute.toString().padLeft(2, '0')}',
                              style: const TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),
              Text(
                widget.request.online ? "Online" : "Physical",
                style: const TextStyle(fontSize: 17),
              ),
            ],
          ),
          const SizedBox(height: 10),
          spinUsr
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.greenAccent),
                )
              : user
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            widget.request.specialist == widget.userId
                                ? patient!.name
                                : specialist!.name,
                            style: const TextStyle(fontSize: 14)),
                        Text(
                            widget.request.specialist == widget.userId
                                ? patient!.telephone
                                : specialist!.speciality,
                            style: const TextStyle(fontSize: 14)),
                      ],
                    )
                  : TextButton(
                      onPressed: () async {
                        // call for patient or specialist data
                        setState(() {
                          spinUsr = true;
                        });
                        if (widget.request.specialist == widget.userId) {
                          User? usr = await getPatient(widget.request.patient);
                          if (usr != null) {
                            setState(() {
                              patient = usr;
                              user = !user;
                              spinUsr = false;
                            });
                          }
                          setState(() {
                            spinUsr = false;
                          });
                        } else {
                          Specialist? usr =
                              await getSpecialist(widget.request.specialist);
                          if (usr != null) {
                            setState(() {
                              specialist = usr;
                              user = !user;
                              spinUsr = false;
                            });
                          }
                          setState(() {
                            spinUsr = false;
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueAccent),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: Text(
                        widget.request.specialist == widget.userId
                            ? "Patient"
                            : "Specialist",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
          const SizedBox(height: 10),
          widget.request.specialist == widget.userId
              ? spinPros
                  ? const Center(
                      child:
                          CircularProgressIndicator(color: Colors.greenAccent),
                    )
                  : closed
                      ? const SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                // call request rejection or edit cancle
                                cancelReq();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.redAccent),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              child: Text(
                                modTime || modDate ? "Cancel" : "Reject",
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // call for request acceptance
                                processReq();
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.greenAccent),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              child: Text(
                                modTime || modDate ? "Modify" : "Accept",
                                style: const TextStyle(fontSize: 17),
                              ),
                            )
                          ],
                        )
              : const Text(
                  'Status: pending',
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 15,
                  ),
                ),
        ],
      ),
    );
  }

  cancelReq() {
    if (closed) {
      Get.snackbar("Notice", "Request closed", backgroundColor: Colors.blue);
      return;
    }
    if (modTime || modDate) {
      setState(() {
        modDate = false;
        modTime = false;
      });
      return;
    }
    // reject a request
    setState(() {
      closed = true;
    });
  }

  processReq() async {
    if (closed) {
      Get.snackbar("Notice", "Request closed", backgroundColor: Colors.blue);
      return;
    }
    final FireStoreController firecon = Get.find<FireStoreController>();
    setState(() {
      spinPros = true;
    });
    if (modTime && modDate) {
      DateTime adjusted =
          DateTime(dt!.year, dt!.month, dt!.day, time!.hour, time!.minute);
      final suc = await firecon.editRequest(widget.request.id!, adjusted);
      if (suc) {
        final res = await firecon.approveRequest(
          widget.request.id!,
          Schedule(
            patient: widget.request.patient,
            specialist: widget.request.specialist,
            online: widget.request.online,
            time: adjusted,
          ),
        );
        if (res) {
          setState(() {
            spinPros = false;
            closed = true;
          });
        }
      }
      setState(() {
        spinPros = false;
      });
      return;
    }
    if (modTime) {
      DateTime adjusted = DateTime(
        widget.request.time.year,
        widget.request.time.month,
        widget.request.time.day,
        time!.hour,
        time!.minute,
      );
      final suc = await firecon.editRequest(widget.request.id!, adjusted);
      if (suc) {
        final res = await firecon.approveRequest(
          widget.request.id!,
          Schedule(
            patient: widget.request.patient,
            specialist: widget.request.specialist,
            online: widget.request.online,
            time: adjusted,
          ),
        );
        if (res) {
          setState(() {
            spinPros = false;
            closed = true;
          });
        }
      }
      setState(() {
        spinPros = false;
      });
      return;
    }
    if (modDate) {
      DateTime adjusted = DateTime(
        dt!.year,
        dt!.month,
        dt!.day,
        widget.request.time.hour,
        widget.request.time.minute,
      );
      final suc = await firecon.editRequest(widget.request.id!, adjusted);
      if (suc) {
        final res = await firecon.approveRequest(
          widget.request.id!,
          Schedule(
            patient: widget.request.patient,
            specialist: widget.request.specialist,
            online: widget.request.online,
            time: adjusted,
          ),
        );
        if (res) {
          setState(() {
            spinPros = false;
            closed = true;
          });
        }
      }
      setState(() {
        spinPros = false;
      });
      return;
    }
    final suc = await firecon.approveRequest(
      widget.request.id!,
      Schedule(
        patient: widget.request.patient,
        specialist: widget.request.specialist,
        online: widget.request.online,
        time: widget.request.time,
      ),
    );
    if (suc) {
      setState(() {
        spinPros = false;
        closed = true;
      });
    }
    setState(() {
      spinPros = false;
    });
  }

  timePick() async {
    if (widget.request.specialist != widget.userId) {
      return;
    }
    if (closed) {
      Get.snackbar("Notice", "Request closed", backgroundColor: Colors.blue);
      return;
    }
    final tm = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (tm != null) {
      setState(() {
        time = tm;
        modTime = true;
      });
    }
  }

  datePick() async {
    if (widget.request.specialist != widget.userId) {
      return;
    }
    if (closed) {
      Get.snackbar("Notice", "Request closed", backgroundColor: Colors.blue);
      return;
    }
    final tm = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2027));
    if (tm != null) {
      setState(() {
        dt = tm;
        modDate = true;
      });
    }
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
