import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:searchfield/searchfield.dart';
import 'package:get/get.dart';

import '../configs/constants.dart';

import '../controllers/controllers.dart';
import '../model/models.dart';

class RegistrationFacility extends StatefulWidget {
  const RegistrationFacility({super.key, required this.name});
  final String name;

  @override
  State<RegistrationFacility> createState() => _RegistrationFacilityState();
}

class _RegistrationFacilityState extends State<RegistrationFacility> {
  bool lincence = false;
  String lincencePath = '';
  String lincenceNm = '';
  TextEditingController pobox = TextEditingController();
  TextEditingController orgmail = TextEditingController();
  TextEditingController facilityName = TextEditingController();
  TextEditingController county = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController lincenceno = TextEditingController();

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
              TextField(
                decoration: const InputDecoration(hintText: 'Name'),
                controller: facilityName,
                onSubmitted: (value) => FocusScope.of(context).unfocus(),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
                decoration:
                    const InputDecoration(hintText: 'Facility Lincence No'),
                controller: lincenceno,
                onSubmitted: (value) => FocusScope.of(context).unfocus(),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'P.O box'),
                controller: pobox,
                onSubmitted: (value) => FocusScope.of(context).unfocus(),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'Facility mail'),
                controller: orgmail,
                onSubmitted: (value) => FocusScope.of(context).unfocus(),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              const SizedBox(height: 10),
              const Text(
                'Lincence',
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
                    child: lincence
                        ? Image.file(File(lincencePath))
                        : const Center(
                            child: Text('No certification picked'),
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
                              lincence ? "Edit" : 'Up load',
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
    facilityName.text = '';
    county.text = '';
    location.text = '';
    lincenceno.text = '';
    lincence = false;
    lincencePath = '';
    pobox.text = '';
    orgmail.text = '';
    setState(() {});
  }

  register() async {
    if (!lincence || pobox.text == '' || county.text == '') {
      Get.snackbar(
        'Error',
        'Please Fill all fields',
        backgroundColor: Colors.redAccent,
      );
      return false;
    }
    if (orgmail.text == '' || location.text == '' || lincenceno.text == '') {
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
    final linUrl =
        await storeCon.upLoadLincence(File(lincencePath), lincenceNm);
    final UserController userCon = Get.find();
    final FireStoreController fireCon = Get.find();
    Facility fc = Facility(
      name: facilityName.text,
      location: [
        county.text,
        location.text,
      ],
      email: orgmail.text,
      pobox: pobox.text,
      lincence: lincenceno.text,
      lincenceImg: linUrl!,
      id: userCon.user()!.uid,
      tests: [],
    );
    bool success = await fireCon.createFacility(fc);
    if (success) {
      String? id = userCon.user()!.uid;
      final resp = await fireCon.updateUserFacility(id);
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
        lincenceNm = img.name;
        lincencePath = img.path;
        lincence = true;
      });
      return;
    }
    Get.snackbar('error', 'image is null');
  }
}
