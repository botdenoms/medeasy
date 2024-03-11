import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../configs/constants.dart';
import '../controllers/controllers.dart';
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
  List<bool> selected = [];
  bool testsPicked = false;
  DateTime? selectedDate;
  DateTime focusedDate = DateTime.now();

  @override
  void initState() {
    selected = List.filled(widget.facility.tests!.length, false);
    super.initState();
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                widget.facility.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Tests offered',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ListView.builder(
                  itemBuilder: itemBuilder,
                  itemCount: widget.facility.tests!.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(height: 20),
              testsPicked
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (selected.contains(true)) {
                              setState(() {
                                testsPicked = true;
                              });
                            }
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
                                'Procede',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 5),
              testsPicked ? const Text('Calendar') : const SizedBox(),
              testsPicked
                  ? TableCalendar(
                      firstDay: DateTime.now(),
                      lastDay: DateTime(2030),
                      focusedDay: focusedDate,
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          selectedDate = selectedDay;
                          focusedDate = selectedDay;
                        });
                        Get.snackbar(
                            'Selected', selectedDate!.toIso8601String());
                      },
                      onPageChanged: (focusedDay) {
                        focusedDate = focusedDay;
                        setState(() {});
                      },
                    )
                  : const SizedBox(),
              const SizedBox(height: 10),
              testsPicked
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            scheduleTest();
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
                                'Schedule',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  scheduleTest() async {
    for (var i = 0; i < selected.length; i++) {
      if (selected[i]) {
        int idx = tests.indexOf(widget.facility.tests![i]);
        final UserController userCon = Get.find();
        final FireStoreController fireCon = Get.find();
        Test t = Test(
          client: userCon.user()!.uid,
          facility: widget.facility.id,
          date: selectedDate!,
          type: idx,
          ref: 'ref',
        );
        final res = await fireCon.scheduleTest(t);
        if (res) {
          Get.snackbar("Success", "Test Scheduled");
        } else {
          Get.snackbar("Error", "Test Scheduled failed");
        }
      }
    }
  }

  Widget? itemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected[index] = !selected[index];
        });
      },
      child: Container(
        color: selected[index] ? Colors.blueAccent : Colors.white,
        margin: const EdgeInsets.all(10),
        child: Center(
          child: Text(widget.facility.tests![index]),
        ),
      ),
    );
  }
}
