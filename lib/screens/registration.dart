import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

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
                'Speciality',
                style: TextStyle(fontSize: 12),
              ),
              const TextField(
                decoration: InputDecoration(hintText: 'Speciality'),
              ),
              const Text(
                'Locality',
                style: TextStyle(fontSize: 12),
              ),
              const TextField(
                decoration: InputDecoration(hintText: 'Location'),
              ),
              const Text(
                'Credentails',
                style: TextStyle(fontSize: 12),
              ),
              const TextField(
                decoration: InputDecoration(hintText: 'Registration No'),
              ),
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
                        : const Text('No certification added'),
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
                            // color: const Color(0xFF1E1EEE),
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
                        : const Text('No Profile added'),
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
                            // color: const Color(0xFF1E1EEE),
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
              const SizedBox(height: 70),
              Row(
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

  register() async {
    if (!cert || !profile) {
      return false;
    }
    final StorageController storeCon = Get.find();
    final profileUrl =
        await storeCon.upLoadProfile(File(profilePath), profileNm);
    final certUrl = await storeCon.upLoadCert(File(certPath), certNm);
    final UserController userCon = Get.find();
    Specialist spl = Specialist(
      speciality: 'speciality',
      location: 'location',
      profile: profileUrl!,
      regNo: 'regNo',
      cert: certUrl!,
      name: widget.name,
      id: userCon.user()!.uid,
    );
    final FireStoreController fireCon = Get.find();
    bool success = await fireCon.addSpecialist(spl);
    return success;
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
