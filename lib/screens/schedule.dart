import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:medeasy/controllers/controllers.dart';
import '../configs/constants.dart';
import '../model/models.dart';
import '../widgets/widgets.dart';

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
  TimeOfDay timeStart = TimeOfDay.now();
  TimeOfDay timeEnd = TimeOfDay.now();
  bool online = true;
  bool picked = false;
  bool sending = false;
  bool sent = false;
  bool fetching = false;
  bool fetchingTests = false;
  List<TimeTable> timeTablels = [];
  List<Test> userTests = [];
  List<int> selectedTests = [];
  String pickedId = '';
  TextEditingController signs = TextEditingController();

  @override
  void initState() {
    getTimeTables();
    super.initState();
  }

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
                'Date',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 10),
              Text(
                'On ${formatDate(widget.date)}',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 20),
              const Text(
                'Schedule',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 10),
              fetching
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        ...timeSlots(),
                        timeTablels.isEmpty
                            ? const Center(child: Text('No Schedule Data'))
                            : const SizedBox(),
                      ],
                    ),
              const SizedBox(height: 20),
              const Text(
                'Time',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 5),
              picked
                  ? Text(
                      'From : ${timeFormat(timeStart)} --> ${timeFormat(timeEnd)}',
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.greenAccent,
                      ),
                    )
                  : const Center(child: Text('Time not pickekd')),
              const SizedBox(height: 10),
              const Text(
                'symptoms',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 2),
              TextField(
                controller: signs,
                maxLines: 8,
                minLines: 3,
                decoration: const InputDecoration(hintText: 'description ....'),
                onSubmitted: (value) => FocusScope.of(context).unfocus(),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              const SizedBox(height: 5),
              const Text(
                'Tests',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 10),
              userTests.isNotEmpty
                  ? SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(2),
                        itemBuilder: testItemBuilder,
                        itemCount: userTests.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    )
                  : const Center(child: Text('No Tests \n Available')),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  fetchingTests
                      ? const CircularProgressIndicator()
                      : GestureDetector(
                          onTap: () {
                            getTests();
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
                                'My test',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 40),
              picked
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 20),
                        sending
                            ? const CircularProgressIndicator(
                                color: Colors.greenAccent,
                              )
                            : GestureDetector(
                                onTap: () {
                                  _showMyDialog();
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
                    )
                  : const SizedBox(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> timeSlots() {
    List<Widget> wdgts = [];
    if (timeTablels.isEmpty) {
      return wdgts;
    }
    for (TimeTable tt in timeTablels) {
      final tc = TimeCard(
        timeTable: tt,
        callBack: (TimeOfDay s, TimeOfDay f) {
          getTests();
          setState(() {
            timeStart = s;
            timeEnd = f;
            picked = true;
            pickedId = tt.id!;
          });
        },
      );
      wdgts.add(tc);
    }
    return wdgts;
  }

  getTimeTables() async {
    setState(() {
      fetching = true;
    });
    // await Future.delayed(const Duration(seconds: 3));
    final FireStoreController fireCon = Get.find();
    final results =
        await fireCon.getTimeTable(widget.specialist.id, widget.date);
    setState(() {
      timeTablels = results!;
      fetching = false;
    });
  }

  getTests() async {
    setState(() {
      fetchingTests = true;
    });
    // await Future.delayed(const Duration(seconds: 3));
    final FireStoreController fireCon = Get.find();
    final UserController userCon = Get.find();
    if (userCon.user() == null) {
      setState(() {
        fetchingTests = false;
      });
      Get.snackbar(
        'Notice',
        'Log in or sign up first',
        backgroundColor: Colors.blueAccent,
      );
      return;
    }
    final results = await fireCon.getTestsOf(userCon.user()!.uid);
    setState(() {
      userTests = results!;
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
        // time = tm;
      });
    }
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
                Text('From: ${timeFormat(timeStart)}'),
                const SizedBox(height: 5),
                Text('To: ${timeFormat(timeEnd)}'),
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
              child: const Text(
                'Send',
                style: TextStyle(color: Colors.greenAccent),
              ),
              onPressed: () {
                requestSend();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  requestSend() async {
    if (sent) {
      Get.snackbar(
        'Notice',
        'Your request is aleady sent',
        backgroundColor: Colors.blueAccent,
      );
      return;
    }
    if (sending) {
      Get.snackbar(
        'Notice',
        'Please wait fro previous request to finish ',
        backgroundColor: Colors.blueAccent,
      );
      return;
    }
    final UserController userCon = Get.find();
    if (userCon.isNull()) {
      Get.snackbar(
        'Notice',
        'Log in or sign up first',
        backgroundColor: Colors.blueAccent,
      );
    } else {
      String? id = userCon.user()!.uid;
      if (widget.specialist.id == id) {
        Get.snackbar(
          'Error',
          'Your can\'t make request to yourself',
          backgroundColor: Colors.blueAccent,
        );
        return;
      }
      setState(() {
        sending = true;
      });
      // fro every item in selecteTest extract id
      List<String> tmp = [];
      if (selectedTests.isNotEmpty) {
        for (int idx in selectedTests) {
          tmp.add(userTests[idx].id!);
        }
      }
      Schedule sch = Schedule(
        specialist: widget.specialist.id,
        patient: id,
        online: online,
        from: DateTime(
          widget.date.year,
          widget.date.month,
          widget.date.day,
          timeStart.hour,
          timeStart.minute,
        ),
        to: DateTime(
          widget.date.year,
          widget.date.month,
          widget.date.day,
          timeEnd.hour,
          timeEnd.minute,
        ),
        tests: tmp,
        signs: signs.text,
      );
      final FireStoreController fireCon = Get.find();
      final resp = await fireCon.createSchedule(sch);
      if (resp) {
        // update specialist db record 2 occupied
        await fireCon.updateTimeTable(pickedId);
        Get.snackbar(
          'Success',
          'Request send',
          backgroundColor: Colors.greenAccent,
        );
        setState(() {
          sent = true;
          sending = false;
        });
      } else {
        Get.snackbar(
          'Failed',
          'Request failed to send',
          backgroundColor: Colors.redAccent,
        );
        setState(() {
          sending = false;
        });
      }
    }
  }

  Widget? testItemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        if (selectedTests.contains(index)) {
          selectedTests.remove(index);
          setState(() {});
          return;
        }
        selectedTests.add(index);
        setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 2),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline_outlined,
              color: selectedTests.contains(index)
                  ? Colors.greenAccent
                  : Colors.grey,
            ),
            Text(testName(userTests[index].type)),
            Text(formatDate(userTests[index].date)),
          ],
        ),
      ),
    );
  }
}
