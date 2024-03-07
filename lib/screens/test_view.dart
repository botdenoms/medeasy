import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/controllers.dart';
import '../model/models.dart';
import '../widgets/widgets.dart';

class TestView extends StatefulWidget {
  const TestView({super.key, required this.test});
  final Test test;

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  bool running = true;
  bool pending = false;
  late BloodTest blt;
  late ImagingTest imgt;

  @override
  void initState() {
    fetchData();
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
              const SizedBox(height: 10),
              const PatientData(
                name: "Jane Doe",
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              pending
                  ? const SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        child: Text('Pending Results \n\t submission...'),
                      ),
                    )
                  : running
                      ? const CircularProgressIndicator()
                      : widget.test.type == 5
                          ? BloodData(bloodTest: blt)
                          : ImagingData(
                              imagingData: imgt,
                            ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  fetchData() async {
    setState(() {
      running = true;
    });
    final FireStoreController fireCon = Get.find();
    if (widget.test.type == 5) {
      final res = await fireCon.bloodData(widget.test.ref);
      if (res == null) {
        setState(() {
          pending = true;
          running = false;
        });
        return;
      }

      setState(() {
        blt = res;
        running = false;
      });
    } else {
      final res = await fireCon.imagingData(widget.test.ref);
      if (res == null) {
        setState(() {
          pending = true;
          running = false;
        });
        return;
      }

      setState(() {
        imgt = res;
        running = false;
      });
    }
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
