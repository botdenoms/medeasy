import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/controllers.dart';
import '../model/models.dart';
import '../widgets/widgets.dart';

class TestForm extends StatefulWidget {
  const TestForm({super.key, required this.test});
  final Test test;

  @override
  State<TestForm> createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  TextEditingController name = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController dob = TextEditingController();

  TextEditingController hermoglobin = TextEditingController();
  TextEditingController wbc = TextEditingController();
  TextEditingController rbc = TextEditingController();
  TextEditingController platelets = TextEditingController();
  TextEditingController cholesterol = TextEditingController();
  TextEditingController triglycerides = TextEditingController();
  TextEditingController glucoseF = TextEditingController();
  TextEditingController glucoseP = TextEditingController();

  List<XFile> images = [];
  List<XFile> l = [];

  bool running = false;
  bool done = false;

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
              const SizedBox(height: 30),
              const Text(
                'Details',
                style: TextStyle(fontSize: 16),
              ),
              PatientInforForm(name: name, gender: gender, dob: dob),
              const Divider(),
              widget.test.type == 5
                  ? BloodForm(
                      hermoglobin: hermoglobin,
                      wbc: wbc,
                      rbc: rbc,
                      platelets: platelets,
                      cholesterol: cholesterol,
                      triglycerides: triglycerides,
                      glucoseF: glucoseF,
                      glucoseP: glucoseP,
                    )
                  : SizedBox(
                      height: 160,
                      width: double.infinity,
                      child: ListView.builder(
                        itemBuilder: imageBuilder,
                        itemCount: images.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
              const SizedBox(height: 10),
              widget.test.type == 5
                  ? const SizedBox(height: 10)
                  : GestureDetector(
                      onTap: () {
                        pickImg();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
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
                        child: const Text('add image'),
                      ),
                    ),
              const SizedBox(height: 10),
              running
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.greenAccent,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            submit();
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
                                'Submit',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  clearField() {
    setState(() {});
  }

  bool emptyField() {
    if (name.text == '' || gender.text == '' || dob.text == '') {
      return true;
    }
    if (widget.test.type != 5 && images.isEmpty) {
      return true;
    }
    return false;
  }

  submit() async {
    if (emptyField()) {
      Get.snackbar('Error', 'Fill all required fields');
      return;
    }
    if (widget.test.type == 5) {
      setState(() {
        running = true;
      });
      final FireStoreController fireCon = Get.find();
      User? usr = await fireCon.userData(widget.test.client);
      BloodTest blt = BloodTest(
        date: DateTime.now(),
        name: usr!.name,
        dob: DateTime.now(),
        gender: int.tryParse(gender.text)!,
        hermoglobin: double.parse(hermoglobin.text),
        wbc: double.parse(wbc.text),
        rbc: int.tryParse(rbc.text)!,
        platelets: double.parse(platelets.text),
        cholesterol: int.parse(cholesterol.text),
        triglycerides: int.parse(triglycerides.text),
        glucoseF: double.parse(glucoseF.text),
        glucoseP: double.parse(glucoseP.text),
      );
      String? ids = await fireCon.createBloodTest(blt);
      final rsp = await fireCon.updateTest(widget.test.id!, ids!);
      if (rsp) {
        Get.snackbar('Success', 'test updated ');
        setState(() {
          running = false;
        });
      } else {
        Get.snackbar('error', 'faild test update try again');
        setState(() {
          running = false;
        });
      }
    } else {
      final StorageController storeCon = Get.find();
      setState(() {
        running = true;
      });
      List<String> imt = [];
      for (XFile im in images) {
        final testUrl = await storeCon.upLoadTestImg(File(im.path), im.name);
        imt.add(testUrl!);
      }
      final FireStoreController fireCon = Get.find();
      User? usr = await fireCon.userData(widget.test.client);
      ImagingTest it = ImagingTest(
        date: DateTime.now(),
        name: usr!.name,
        dob: DateTime.now(),
        gender: int.tryParse(gender.text)!,
        images: imt,
      );
      String? ids = await fireCon.createImgTest(it);
      final rsp = await fireCon.updateTest(widget.test.id!, ids!);
      if (rsp) {
        Get.snackbar('Success', 'test updated ');
        setState(() {
          running = false;
        });
      } else {
        Get.snackbar('error', 'faild test update try again');
        setState(() {
          running = false;
        });
      }
    }
  }

  pickImg() async {
    final imgPicker = ImagePicker();
    XFile? img = await imgPicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      l.add(img);
      setState(() {
        images = l;
      });
      return;
    }
    Get.snackbar('error', 'image is null');
  }

  Widget? imageBuilder(BuildContext context, int index) {
    return ImageForm(img: true, pathUrl: images[index].path);
  }
}
