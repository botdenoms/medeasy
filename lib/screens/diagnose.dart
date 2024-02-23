import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';
import '../model/models.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key, required this.schedule});
  final Schedule schedule;

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  TextEditingController finds = TextEditingController();
  TextEditingController recos = TextEditingController();
  TextEditingController presc = TextEditingController();
  bool addingPresc = false;
  bool running = false;
  List<String> prescpts = [];

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
              const Text(
                'Findings',
                style: TextStyle(fontSize: 17),
              ),
              TextField(
                maxLines: 8,
                minLines: 3,
                controller: finds,
                decoration: const InputDecoration(hintText: 'Findings ....'),
                onSubmitted: (value) => FocusScope.of(context).unfocus(),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              const SizedBox(height: 10),
              const Text(
                'Recommendations',
                style: TextStyle(fontSize: 17),
              ),
              TextField(
                maxLines: 8,
                minLines: 3,
                controller: recos,
                decoration:
                    const InputDecoration(hintText: 'Recommendations ....'),
                onSubmitted: (value) => FocusScope.of(context).unfocus(),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              const SizedBox(height: 10),
              const Text(
                'Prescriptions',
                style: TextStyle(fontSize: 17),
              ),
              prescpts.isEmpty
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text('No Prescription(s)'),
                          Text('added'),
                        ],
                      ),
                    )
                  : const SizedBox(height: 15),
              const SizedBox(height: 5),
              ...prescTxts(),
              TextField(
                controller: presc,
                decoration: const InputDecoration(
                  hintText: 'Prescription Info....',
                ),
                onSubmitted: (value) => FocusScope.of(context).unfocus(),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              const SizedBox(height: 5),
              Center(
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (presc.text == '') {
                      setState(() {});
                    } else {
                      prescpts.add(presc.text);
                      presc.text = '';
                      setState(() {});
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: running
                    ? const CircularProgressIndicator()
                    : TextButton(
                        onPressed: () {
                          submitDiagnosis();
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> prescTxts() {
    List<Widget> wdgts = [];
    if (prescpts.isEmpty) {
      return wdgts;
    }
    int c = 1;
    for (String tt in prescpts) {
      final tc = Text('$c. $tt');
      wdgts.add(tc);
      c += 1;
    }
    return wdgts;
  }

  submitDiagnosis() async {
    if (finds.text == '' || recos.text == '') {
      Get.snackbar(
        'Error',
        'Please Fill all fields',
        backgroundColor: Colors.redAccent,
      );
      return;
    }
    final FireStoreController fireCon = Get.find();
    setState(() {
      running = true;
    });
    Diagnosis dg = Diagnosis(
      findings: finds.text,
      recommends: recos.text,
      prescripts: prescpts,
      specialist: widget.schedule.specialist,
      patient: widget.schedule.patient,
      schedule: widget.schedule.id!,
      date: DateTime.now(),
    );
    final resp = await fireCon.createDiagnosis(dg);
    // update status of schedule
    if (resp != null) {
      Get.snackbar(
        'Success',
        'Diagnisis successfully added',
        backgroundColor: Colors.greenAccent,
      );
      setState(() {
        running = false;
      });
    } else {
      Get.snackbar(
        'Error',
        'Failded to submit your Diagnisis \n try again',
        backgroundColor: Colors.redAccent,
      );
      setState(() {
        running = false;
      });
    }
    setState(() {
      running = false;
    });
  }
}
