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
      appBar: AppBar(),
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
              const SizedBox(height: 5),
              pending
                  ? const Text('Pending...')
                  : running
                      ? const CircularProgressIndicator()
                      : widget.test.type == 5
                          ? BloodData(bloodTest: blt)
                          : ImagingData(
                              imagingData: imgt,
                            ),
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
}
