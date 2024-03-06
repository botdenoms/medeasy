import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/controllers.dart';
import '../model/models.dart';
import '../screens/screens.dart';

class StatsCard extends StatefulWidget {
  const StatsCard({super.key, required this.specialist});
  final bool specialist;

  @override
  State<StatsCard> createState() => _StatsCardState();
}

class _StatsCardState extends State<StatsCard> {
  DateTime? joined;
  DateTime? verifiedOn;
  LatLng? location;
  late User _user;
  bool fetching = true;
  List<Schedule> schedules = [];

  @override
  void initState() {
    buildUserprofile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return fetching
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    "Joined on:",
                    style: TextStyle(fontSize: 17, color: Color(0xFF1E1E1E)),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    joined == null
                        ? "null"
                        : joined!
                            .toString()
                            .substring(0, joined.toString().length - 7),
                    style: const TextStyle(
                        fontSize: 17, color: Colors.greenAccent),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Divider(
                color: Color(0xFF1E1E1E),
              ),
              const SizedBox(height: 5),
              _user.specialist == true
                  ? Row(
                      children: [
                        const Text(
                          'Verified on: ',
                          style:
                              TextStyle(fontSize: 17, color: Color(0xFF1E1E1E)),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          verifiedOn == null
                              ? 'Not Verified'
                              : verifiedOn!
                                  .toString()
                                  .substring(0, joined.toString().length - 7),
                          style: TextStyle(
                            fontSize: 17,
                            color: verifiedOn == null
                                ? Colors.redAccent
                                : Colors.greenAccent,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 5),
              _user.specialist == true
                  ? verifiedOn != null
                      ? Column(
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.add_location_outlined),
                                SizedBox(width: 5),
                                Text(
                                  'Add map address',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final result =
                                        await Navigator.of(context).push(
                                      MaterialPageRoute<LatLng?>(
                                        builder: (BuildContext context) =>
                                            const GeoPicker(),
                                      ),
                                    );
                                    if (result != null) {
                                      setState(() {
                                        location = result;
                                      });
                                      Get.snackbar(
                                        'Infor',
                                        '$location',
                                        backgroundColor: Colors.yellowAccent,
                                      );
                                    }
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
                                    child: const Text('On Map'),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Row(
                                  children: [
                                    const Text(
                                      'Lat: ',
                                    ),
                                    location != null
                                        ? Text(location!.latitude
                                            .toStringAsFixed(3))
                                        : const Text(' NA '),
                                    const SizedBox(width: 5.0),
                                    const Text(
                                      'Long: ',
                                    ),
                                    location != null
                                        ? Text(location!.longitude
                                            .toStringAsFixed(3))
                                        : const Text(' NA '),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (location != null) {
                                      updateGeo(location);
                                    } else {
                                      Get.snackbar('Error', "Location Null",
                                          backgroundColor: Colors.red);
                                    }
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
                                    child: const Text('Update'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : const SizedBox()
                  : const SizedBox(),
              _user.specialist == true
                  ? verifiedOn != null
                      ? Column(
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.date_range_rounded),
                                SizedBox(width: 5),
                                Text(
                                  'Update schedule',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final result =
                                        await Navigator.of(context).push(
                                      MaterialPageRoute<LatLng?>(
                                        builder: (BuildContext context) =>
                                            const ScheduleMgnt(),
                                      ),
                                    );
                                    if (result != null) {
                                      setState(() {
                                        location = result;
                                      });
                                      Get.snackbar(
                                        'Infor',
                                        '$location',
                                        backgroundColor: Colors.yellowAccent,
                                      );
                                    }
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
                                    child: const Text('Schedule'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              children: [
                                Text(
                                  'Pending schedules: ${schedules.length} ',
                                  style: const TextStyle(fontSize: 17),
                                ),
                                const SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () {
                                    if (schedules.isEmpty) {
                                      return;
                                    }
                                    Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            ScheduleMng(
                                          schedule: schedules,
                                        ),
                                      ),
                                    );
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
                                    child: const Text('View'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : const SizedBox()
                  : const SizedBox(),
            ],
          );
  }

  updateGeo(geoloc) async {
    final FireStoreController fireCon = Get.find();
    final UserController usr = Get.find();
    String userId = usr.user()!.uid;
    final resp = await fireCon.addGeoData(userId, geoloc);
    if (resp) {
      Get.snackbar('Ok', "Sucess", backgroundColor: Colors.greenAccent);
    } else {
      Get.snackbar('Error', "Failed", backgroundColor: Colors.red);
    }
  }

  getSchedules() async {
    setState(() {});
    final FireStoreController fireCon = Get.find();
    final UserController usr = Get.find();
    final res = await fireCon.getPendingSchedulesOf(usr.user()!.uid);
    setState(() {
      schedules = res!;
    });
  }

  buildUserprofile() async {
    getSchedules();
    // return infor on user
    final FireStoreController fireCon = Get.find();
    final UserController usr = Get.find();
    String userId = usr.user()!.uid;
    setState(() {
      fetching = true;
    });
    final resp = await fireCon.userData(userId);
    if (resp != null) {
      final spe = await fireCon.specialistData(userId);
      if (spe != null) {
        if (spe.verified) {
          setState(() {
            fetching = false;
            _user = resp;
            joined = _user.at;
            verifiedOn = spe.at;
            location = spe.geo;
          });
          return;
        }
        setState(() {
          fetching = false;
          _user = resp;
          joined = _user.at;
        });
      } else {
        setState(() {
          fetching = false;
          _user = resp;
          joined = _user.at;
        });
      }
    } else {
      Get.snackbar("Error", "Null user");
      setState(() {
        fetching = false;
      });
    }
    // final spe = await fireCon.specialistData(userId);
  }
}
