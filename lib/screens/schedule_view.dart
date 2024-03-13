import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/constants.dart';
import '../controllers/controllers.dart';
import '../model/models.dart';
import 'screens.dart';

class ScheduleViewDetails extends StatefulWidget {
  const ScheduleViewDetails({super.key, required this.schedule});
  final Schedule schedule;

  @override
  State<ScheduleViewDetails> createState() => _ScheduleViewDetailsState();
}

class _ScheduleViewDetailsState extends State<ScheduleViewDetails> {
  bool fetchingTests = false;
  Test? focusTest;
  List<Test> testsList = [];

  @override
  void initState() {
    getTests();
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              const Text(
                'Schedule Date',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 5),
              Text(
                formatDate(widget.schedule.from),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'From ${timeFormat(widget.schedule.from)}',
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'To ${timeFormat(widget.schedule.to)}',
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Tests Attached: ${widget.schedule.tests!.length}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 5),
              fetchingTests
                  ? const CircularProgressIndicator()
                  : testsList.isEmpty
                      ? const SizedBox(
                          height: 80,
                          width: double.infinity,
                          child: Center(
                              child: Text('No tests data \n\t\t shared')),
                        )
                      : SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(2),
                            itemBuilder: testItemBuilder,
                            itemCount: testsList.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () async {
                  final UserController userCon = Get.find();
                  final usrId = userCon.user()!.uid;
                  final dg = await getDiagnosis(widget.schedule.id!);
                  if (dg != null) {
                    diagnoseView(dg);
                  } else {
                    diagnose(usrId);
                  }
                },
                child: const Text(
                  "Diagnose",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  timeFormat(DateTime dt) {
    String hrs = dt.hour.toString().padRight(2, '0');
    String mins = dt.minute.toString().padRight(2, '0');
    return '$hrs : $mins';
  }

  diagnoseView(Diagnosis dg) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => DiagnosisView(
          diagnosis: dg,
        ),
      ),
    );
  }

  diagnose(String usr) async {
    if (widget.schedule.patient == usr) {
      Get.snackbar('Notice', 'Your can\'t Diagnose your self');
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => DiagnosisScreen(
          schedule: widget.schedule,
        ),
      ),
    );
  }

  Future<Diagnosis?> getDiagnosis(String id) async {
    final FireStoreController firecon = Get.find<FireStoreController>();
    return await firecon.getDiagnosisByScheduleId(id);
  }

  Widget? testItemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => TestView(
              test: testsList[index],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              spreadRadius: 2,
              blurRadius: 1,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '${testName(testsList[index].type)} test',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            Text(
              formatDate(testsList[index].date),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  getTests() async {
    setState(() {
      fetchingTests = true;
    });
    // await Future.delayed(const Duration(seconds: 3));
    final FireStoreController fireCon = Get.find();
    List<Test> tmp = [];
    for (String id in widget.schedule.tests!) {
      final res = await fireCon.getTest(id);
      if (res != null) {
        tmp.add(res);
      }
    }
    setState(() {
      testsList = tmp;
      fetchingTests = false;
    });
  }

  String testName(int index) {
    return tests[index];
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
      case 1:
        month = 'January';
        break;
      case 2:
        month = 'February';
        break;
      case 3:
        month = 'March';
        break;
      case 4:
        month = 'April';
        break;
      case 5:
        month = 'May';
        break;
      case 6:
        month = 'June';
        break;
      case 7:
        month = 'July';
        break;
      case 8:
        month = 'August';
        break;
      case 9:
        month = 'September';
        break;
      case 10:
        month = 'Octorber';
        break;
      case 11:
        month = 'November';
        break;
      case 12:
        month = 'December';
        break;
      default:
        break;
    }
    return '$day $month, ${dt.year}';
  }
}
