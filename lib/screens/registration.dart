import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:searchfield/searchfield.dart';
import 'package:get/get.dart';

import '../configs/constants.dart';

import '../controllers/controllers.dart';
import '../model/models.dart';

class Registration extends StatefulWidget {
  const Registration({super.key, required this.name});
  final String name;

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool cert = false;
  bool profile = false;
  String certPath = '';
  String certNm = '';
  String profilePath = '';
  String profileNm = '';
  TextEditingController speciality = TextEditingController();
  TextEditingController county = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController regno = TextEditingController();

  bool running = false;

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
              const SizedBox(height: 10),
              const Text(
                'Details',
                style: TextStyle(fontSize: 16),
              ),
              SearchField<String>(
                suggestions: suggestionSpecialists.map((e) {
                  return SearchFieldListItem<String>(e,
                      item: e,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          e,
                          style: const TextStyle(fontSize: 15.0),
                        ),
                      ));
                }).toList(),
                controller: speciality,
                searchInputDecoration: const InputDecoration(
                  hintText: 'Speciality',
                ),
                onSubmit: (submText) {
                  if (!suggestionSpecialists.contains(submText)) {
                    // add to specialities collection
                  }
                  FocusScope.of(context).unfocus();
                },
                onSuggestionTap: (listItem) {
                  FocusScope.of(context).unfocus();
                },
              ),
              SearchField<String>(
                suggestions: suggestionsCounties.map((e) {
                  return SearchFieldListItem<String>(e,
                      item: e,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          e,
                          style: const TextStyle(fontSize: 15.0),
                        ),
                      ));
                }).toList(),
                controller: county,
                searchInputDecoration: const InputDecoration(
                  hintText: 'County',
                ),
                onSubmit: (p0) => FocusScope.of(context).unfocus(),
                onSuggestionTap: (p0) => FocusScope.of(context).unfocus(),
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'Location'),
                controller: location,
                onSubmitted: (value) => FocusScope.of(context).unfocus(),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'Registration No'),
                controller: regno,
                onSubmitted: (value) => FocusScope.of(context).unfocus(),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              const SizedBox(height: 10),
              const Text(
                'Certification',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: cert
                        ? Image.file(File(certPath))
                        : const Center(
                            child: Text('No certification added'),
                          ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          pickCert();
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
                          child: Center(
                            child: Text(
                              cert ? "Edit" : 'Up load',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ],
              ),
              const Text(
                'Profile',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: profile
                        ? Image.file(File(profilePath))
                        : const Center(child: Text('No Profile added')),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          pickProfile();
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
                          child: Center(
                            child: Text(
                              profile ? "Edit" : 'Up load',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
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
                            register();
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
                                'Register',
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
    speciality.text = '';
    county.text = '';
    location.text = '';
    regno.text = '';
    cert = false;
    profile = false;
    certPath = '';
    certNm = '';
    profilePath = '';
    profileNm = '';
    setState(() {});
  }

  register() async {
    if (!cert || !profile || county.text == '') {
      Get.snackbar(
        'Error',
        'Please Fill all fields',
        backgroundColor: Colors.redAccent,
      );
      return false;
    }
    if (speciality.text == '' || location.text == '' || regno.text == '') {
      Get.snackbar(
        'Error',
        'Please Fill all fields',
        backgroundColor: Colors.redAccent,
      );
      return false;
    }
    final StorageController storeCon = Get.find();
    setState(() {
      running = true;
    });
    final profileUrl =
        await storeCon.upLoadProfile(File(profilePath), profileNm);
    final certUrl = await storeCon.upLoadCert(File(certPath), certNm);
    final UserController userCon = Get.find();
    Specialist spl = Specialist(
      speciality: speciality.text,
      location: [
        county.text,
        location.text,
      ],
      profile: profileUrl!,
      regNo: regno.text,
      cert: certUrl!,
      name: widget.name,
      id: userCon.user()!.uid,
    );
    final FireStoreController fireCon = Get.find();
    bool success = await fireCon.addSpecialist(spl);
    if (success) {
      String? id = userCon.user()!.uid;
      final resp = await fireCon.updateUser(id);
      if (resp) {
        Get.snackbar(
          'Success',
          'Data successfully added',
          backgroundColor: Colors.greenAccent,
        );
        setState(() {
          running = false;
        });
        clearField();
      } else {
        Get.snackbar(
          'Error',
          'Failded to update your records \n try again',
          backgroundColor: Colors.redAccent,
        );
        setState(() {
          running = false;
        });
      }
    } else {
      Get.snackbar(
        'Error',
        'Failded to add your records \n try again',
        backgroundColor: Colors.redAccent,
      );
      setState(() {
        running = false;
      });
    }
  }

  pickCert() async {
    final imgPicker = ImagePicker();
    XFile? img = await imgPicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        certNm = img.name;
        certPath = img.path;
        cert = true;
      });
      return;
    }
    Get.snackbar('error', 'image is null');
  }

  pickProfile() async {
    final imgPicker = ImagePicker();
    XFile? img = await imgPicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        profileNm = img.name;
        profilePath = img.path;
        profile = true;
      });
      return;
    }
    Get.snackbar('error', 'image is null');
  }
}
