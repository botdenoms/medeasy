import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';
import '../model/models.dart';

class SpecialistActs extends StatefulWidget {
  const SpecialistActs({super.key});

  @override
  State<SpecialistActs> createState() => _SpecialistActsState();
}

class _SpecialistActsState extends State<SpecialistActs> {
  late Specialist _specialist;
  bool pending = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        pending
            ? const Center(
                child: Text('Waiting for verification ...'),
              )
            : Column(
                children: [
                  Text(_specialist.name),
                  const SizedBox(height: 5),
                  Text(_specialist.speciality),
                  Row(
                    children: const [
                      Icon(Icons.add_location_outlined),
                      SizedBox(width: 5),
                      Text(
                        'Pending Schedules: 0',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  const SizedBox(),
                  Row(
                    children: const [
                      Icon(Icons.add_location_outlined),
                      SizedBox(width: 5),
                      Text(
                        'Scedule Update',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ],
              ),
      ],
    );
  }

  buildUserprofile() async {
    // return infor on user
    final FireStoreController fireCon = Get.find();
    final UserController usr = Get.find();
    String userId = usr.user()!.uid;
    final resp = await fireCon.userData(userId);
    if (resp != null) {
      final spe = await fireCon.specialistData(userId);
      if (spe!.verified) {
        setState(() {
          pending = false;
          _specialist = spe;
        });
      } else {
        setState(() {
          pending = true;
          _specialist = spe;
        });
      }
    } else {
      setState(() {
        pending = true;
      });
    }
  }
}
