import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../configs/constants.dart';
import '../controllers/controllers.dart';
import '../model/models.dart';
import '../screens/screens.dart';

class FacilityStatus extends StatefulWidget {
  const FacilityStatus({super.key, required this.specialist});
  final bool specialist;

  @override
  State<FacilityStatus> createState() => _FacilityStatusState();
}

class _FacilityStatusState extends State<FacilityStatus> {
  DateTime? joined;
  DateTime? verifiedOn;
  LatLng? location;
  late User _user;
  List<String> offers = [];
  List<String> selected = [];
  bool fetching = true;
  bool testSpin = true;
  bool testUpdate = false;
  List<Test>? testsList = [];
  List<int> selectedTests = [];
  String? fcId;

  @override
  void initState() {
    buildUserprofile();
    getTests();
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
              _user.facility == true
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
                              ? 'Verification pending..'
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
              _user.facility == true
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
              _user.facility == true
                  ? verifiedOn != null
                      ? Column(
                          children: [
                            const SizedBox(height: 18),
                            Row(
                              children: [
                                const Text(
                                  'Pending Tests: ',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  testsList!.length.toString(),
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    if (testsList!.isEmpty ||
                                        testsList == null) {
                                      return;
                                    }
                                    Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            PendingTests(
                                          tests: testsList!,
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
              const SizedBox(height: 5),
              _user.facility == true
                  ? verifiedOn != null
                      ? Column(
                          children: [
                            const SizedBox(height: 18),
                            Row(
                              children: const [
                                Text(
                                  'Offering Tests',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            fetching
                                ? const CircularProgressIndicator()
                                : SizedBox(
                                    height: 30,
                                    width: double.infinity,
                                    child: ListView.builder(
                                      itemBuilder: itemBuilder,
                                      itemCount: offers.length,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                            const SizedBox(height: 10),
                            // tests list
                            testUpdate
                                ? SizedBox(
                                    height: 40,
                                    width: double.infinity,
                                    child: ListView.builder(
                                      itemBuilder: itemBuilderTests,
                                      itemCount: tests.length,
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5.0,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (testUpdate == false) {
                                      initTestsOffered();
                                      setState(() {
                                        testUpdate = true;
                                      });
                                      return;
                                    }
                                    updateTests();
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
                                    child: Text(
                                      testUpdate ? 'Update' : "Edit Offers",
                                    ),
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

  updateTests() async {
    final FireStoreController fireCon = Get.find();
    List<String> tmp = [];
    for (int idx in selectedTests) {
      tmp.add(tests[idx]);
    }
    final resp = await fireCon.testsOfferedUpdate(fcId!, tmp);
    if (resp) {
      Get.snackbar('Success', 'Updated tests offered');
      setState(() {
        testUpdate = false;
      });
      return;
    }
    Get.snackbar('Error', 'Failed to Updated tests offered');
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

  buildUserprofile() async {
    // return infor on user
    final FireStoreController fireCon = Get.find();
    final UserController usr = Get.find();
    String userId = usr.user()!.uid;
    setState(() {
      fetching = true;
    });
    final resp = await fireCon.userData(userId);
    if (resp != null) {
      final fc = await fireCon.getFacility(userId);
      if (fc == null) {
        setState(() {
          fetching = false;
          _user = resp;
          joined = _user.at;
        });
        return;
      }
      if (fc.verified) {
        setState(() {
          offers = [...fc.tests!];
          fetching = false;
          _user = resp;
          joined = _user.at;
          verifiedOn = fc.at;
          location = fc.geo;
          fcId = fc.id;
        });
        return;
      } else {
        setState(() {
          fetching = false;
          _user = resp;
          joined = _user.at;
        });
        return;
      }
    } else {
      Get.snackbar("Error", "Null user");
      setState(() {
        fetching = false;
      });
    }
  }

  getTests() async {
    setState(() {
      testSpin = true;
    });
    final FireStoreController fireCon = Get.find();
    final UserController usr = Get.find();
    final res = await fireCon.getTestsOn(usr.user()!.uid);
    setState(() {
      testsList = res;
      testSpin = false;
    });
  }

  Widget? itemBuilder(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(left: BorderSide()),
      ),
      child: Center(
        child: Text(
          offers[index],
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget? itemBuilderTests(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        testOfferUpdator(index);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 5.0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
        child: Row(
          children: [
            Text(tests[index]),
            const SizedBox(width: 10),
            selectedTests.contains(index)
                ? const Icon(
                    Icons.dangerous_outlined,
                    color: Colors.redAccent,
                  )
                : const Icon(
                    Icons.add_circle_outline,
                    color: Colors.greenAccent,
                  ),
          ],
        ),
      ),
    );
  }

  initTestsOffered() {
    for (String tst in offers) {
      int idx = tests.indexOf(tst);
      if (idx != -1) {
        selectedTests.add(idx);
      }
    }
    setState(() {});
  }

  testOfferUpdator(int index) {
    if (selectedTests.contains(index)) {
      selectedTests.remove(index);
      setState(() {});
      return;
    }
    selectedTests.add(index);
    setState(() {});
  }
}
