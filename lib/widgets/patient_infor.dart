import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';
import '../model/models.dart';

class PatientInforForm extends StatefulWidget {
  const PatientInforForm({
    super.key,
    required this.test,
    required this.name,
    required this.gender,
    required this.dob,
  });
  final Test test;
  final TextEditingController gender;
  final TextEditingController dob;
  final TextEditingController name;

  @override
  State<PatientInforForm> createState() => _PatientInforFormState();
}

class _PatientInforFormState extends State<PatientInforForm> {
  bool fetching = false;
  bool error = false;
  bool present = false;
  String name = '';
  String email = '';
  String phone = '';
  bool male = true;
  DateTime? dt;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // get patient data
        error
            ? fetching
                ? const CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          clientDetails();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(
                            10.0,
                          ),
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
                              'Patient',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  )
            : present
                ? const SizedBox()
                : fetching
                    ? const CircularProgressIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              clientDetails();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(
                                10.0,
                              ),
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
                                  'Patient',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
        const SizedBox(height: 10),
        present
            ? Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        phone,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        email,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              )
            : const SizedBox(),
        const SizedBox(height: 10),
        //  gender field
        present
            ? Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.gender.text = 'Male';
                      setState(() {
                        male = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(
                        10.0,
                      ),
                      decoration: BoxDecoration(
                        color: male ? Colors.blueAccent : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Male',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      widget.gender.text = 'Female';
                      setState(() {
                        male = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(
                        10.0,
                      ),
                      decoration: BoxDecoration(
                        color: !male ? Colors.blueAccent : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Female',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        const SizedBox(height: 10),
        // date of birth
        present
            ? Row(
                children: const [
                  Text(
                    'Dob',
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              )
            : const SizedBox(),
        const SizedBox(height: 5),
        present
            ? Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      datePick();
                    },
                    child: Text(
                      dateString(dt),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        const SizedBox(height: 5),
      ],
    );
  }

  datePick() async {
    final tdt = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.parse("1963-02-27"),
      lastDate: DateTime.parse("2030-02-27"),
    );
    if (tdt != null) {
      widget.dob.text = toDob(tdt);
      setState(() {
        dt = tdt;
      });
    }
  }

  String toDob(DateTime? dt) {
    if (dt == null) {
      return "2000-01-01";
    }
    var mnt = dt.month.toString().padLeft(2, '0');
    var dy = dt.day.toString().padLeft(2, '0');
    var yr = dt.year;
    return "$yr-$mnt-$dy";
  }

  clientDetails() async {
    setState(() {
      fetching = true;
    });
    final FireStoreController fireCon = Get.find();
    User? usr = await fireCon.userData(widget.test.client);
    if (usr == null) {
      Get.snackbar(
        'Error',
        'Null user please try again',
        backgroundColor: Colors.redAccent,
      );
      setState(() {
        error = true;
        fetching = false;
      });
    } else {
      name = usr.name;
      phone = usr.telephone;
      email = usr.email;
      widget.name.text = name;
      setState(() {
        error = false;
        fetching = false;
        present = true;
      });
    }
  }

  String dateString(DateTime? dt) {
    if (dt == null) {
      return "mm/dd/yyyy";
    }
    var mnt = dt.month.toString().padLeft(2, '0');
    var dy = dt.day.toString().padLeft(2, '0');
    var yr = dt.year;
    return "$mnt/$dy/$yr";
  }
}
