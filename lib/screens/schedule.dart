import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:medeasy/controllers/controllers.dart';
import '../model/models.dart';

class Scheduler extends StatefulWidget {
  const Scheduler({
    super.key,
    required this.date,
    required this.specialist,
  });
  final DateTime date;
  final Specialist specialist;

  @override
  State<Scheduler> createState() => _SchedulerState();
}

class _SchedulerState extends State<Scheduler> {
  TimeOfDay time = TimeOfDay.now();
  bool online = true;
  bool sending = false;
  bool sent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(height: 20),
              const Text(
                'Schedule Setup',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 10),
              Text(
                'On ${formatDate(widget.date)}',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 20),
              const Text(
                'Type',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    online = !online;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 40,
                  width: double.infinity,
                  color: Colors.black26,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          online ? 'Online' : 'Physical',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Icon(
                          Icons.change_circle_rounded,
                          color: Color(0xFF1E1E1E),
                        ),
                      ]),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Time',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  timePick();
                },
                child: Row(
                  children: [
                    const Icon(Icons.timer_outlined),
                    Text(
                      timeFormat(time),
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      request();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x22000000),
                            spreadRadius: 2,
                            blurRadius: 1,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Request',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
      case 0:
        month = 'January';
        break;
      case 1:
        month = 'February';
        break;
      case 2:
        month = 'March';
        break;
      case 3:
        month = 'April';
        break;
      case 4:
        month = 'May';
        break;
      case 5:
        month = 'June';
        break;
      case 6:
        month = 'July';
        break;
      case 7:
        month = 'August';
        break;
      case 8:
        month = 'September';
        break;
      case 9:
        month = 'Octorber';
        break;
      case 10:
        month = 'November';
        break;
      case 11:
        month = 'December';
        break;
      default:
        break;
    }
    return '$day $month, ${dt.year}';
  }

  String timeFormat(TimeOfDay time) {
    String hr = time.hour.toString().padLeft(2, '0');
    String min = time.minute.toString().padLeft(2, '0');
    return '$hr:$min ${time.period.name}';
  }

  timePick() async {
    final tm = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (tm != null) {
      setState(() {
        time = tm;
      });
    }
  }

  request() {
    // set up for date and Time
    _showMyDialog();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Schedule setup')),
          titlePadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Date: ${formatDate(widget.date)}'),
                const SizedBox(height: 5),
                Text('Time: ${timeFormat(time)}'),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: sending
                  ? const CircularProgressIndicator(
                      color: Colors.greenAccent,
                    )
                  : const Text(
                      'Send',
                      style: TextStyle(color: Colors.greenAccent),
                    ),
              onPressed: () {
                if (sent) {
                  Navigator.of(context).pop();
                }
                requestSend();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> requestSend() async {
    if (sent) {
      return false;
    }
    // send request on the given date and time
    // attach user records to doctor in view
    final UserController userCon = Get.find();
    final FireStoreController fireCon = Get.find();
    String? id = userCon.user()!.uid;
    if (widget.specialist.id == id) {
      Get.snackbar(
        'Error',
        'Your can\'t make request to yourself',
        backgroundColor: Colors.blueAccent,
      );
      return false;
    }
    Request req = Request(
      specialist: widget.specialist.id,
      online: online,
      time: DateTime(
        widget.date.year,
        widget.date.month,
        widget.date.day,
        time.hour,
        time.minute,
      ),
      patient: id,
    );
    final resp = await fireCon.createRequest(req);
    if (resp) {
      // success response
      Get.snackbar(
        'Success',
        'Request send',
        backgroundColor: Colors.greenAccent,
      );
      setState(() {
        sent = true;
      });
    } else {
      Get.snackbar(
        'Failed',
        'Request failed to send',
        backgroundColor: Colors.redAccent,
      );
      setState(() {
        sending = !sending;
      });
    }
    setState(() {
      sending = !sending;
    });
    return resp;
  }
}
