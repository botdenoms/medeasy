import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/models.dart';

class FireStoreController extends GetxController {
  final _fireStore = FirebaseFirestore.instance;

  fireStore() {
    return _fireStore;
  }

  Future<String?> createDiagnosis(Diagnosis dgn) async {
    try {
      DocumentReference rf = _fireStore.collection('diagnosis').doc();
      await rf.set(dgn.toMap());
      return rf.id;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<List<Diagnosis>?> getDiagnosisOf(String id) async {
    List<Diagnosis> retList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> query = await _fireStore
          .collection('diagnosis')
          .where('patient', isEqualTo: id)
          .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      for (QueryDocumentSnapshot<Map<String, dynamic>> element in data) {
        Diagnosis t = Diagnosis(
          findings: element['findings'],
          recommends: element['recommends'],
          prescripts: [...element['prescripts']],
          patient: element['patient'],
          specialist: element['specialist'],
          schedule: element['schedule'],
          date: DateTime.fromMillisecondsSinceEpoch(
              element['date'].seconds * 1000),
          // id: element.id,
        );
        retList.add(t);
      }
      return retList;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<Diagnosis?> getDiagnosisByScheduleId(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> query = await _fireStore
          .collection('diagnosis')
          .where('schedule', isEqualTo: id)
          .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      if (data.isEmpty) {
        return null;
      }
      for (QueryDocumentSnapshot<Map<String, dynamic>> element in data) {
        Diagnosis t = Diagnosis(
          findings: element['findings'],
          recommends: element['recommends'],
          prescripts: [...element['prescripts']],
          patient: element['patient'],
          specialist: element['specialist'],
          schedule: element['schedule'],
          date: DateTime.fromMillisecondsSinceEpoch(
              element['date'].seconds * 1000),
          // id: element.id,
        );
        return t;
      }
      return null;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<String?> createImgTest(ImagingTest imgt) async {
    try {
      DocumentReference rf = _fireStore.collection('imaging').doc();
      await rf.set(imgt.toMap());
      return rf.id;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<ImagingTest?> imagingData(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> data =
          await _fireStore.collection('imaging').doc(id).get();
      if (data.exists) {
        final map = data.data()!;
        ImagingTest imt = ImagingTest(
          date: DateTime.fromMillisecondsSinceEpoch(map['date'].seconds * 1000),
          name: map['name'],
          dob: DateTime.fromMillisecondsSinceEpoch(map['dob'].seconds * 1000),
          gender: map['gender'],
          images: [...map['images']],
        );
        return imt;
      }
      return null;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  // 14 6 200 6 150 70 84 90
  Future<String?> createBloodTest(BloodTest blt) async {
    try {
      DocumentReference rf = _fireStore.collection('bloodTest').doc();
      await rf.set(blt.toMap());
      return rf.id;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<BloodTest?> bloodData(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> data =
          await _fireStore.collection('bloodTest').doc(id).get();
      if (data.exists) {
        final map = data.data()!;
        BloodTest imt = BloodTest(
          date: DateTime.fromMillisecondsSinceEpoch(map['date'].seconds * 1000),
          name: map['name'],
          dob: DateTime.fromMillisecondsSinceEpoch(map['dob'].seconds * 1000),
          gender: map['gender'],
          hermoglobin: map['hermoglobin'],
          wbc: map['wbc'],
          rbc: map['rbc'],
          platelets: map['platelets'],
          cholesterol: map['cholesterol'],
          triglycerides: map['triglycerides'],
          glucoseF: map['glucoseF'],
          glucoseP: map['glucoseP'],
        );
        return imt;
      }
      return null;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<bool> addSpecialist(Specialist user) async {
    try {
      await _fireStore.collection('specialists').doc(user.id).set(user.toMap());
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return false;
    }
  }

  Future<List<Specialist>?> getSpecialists() async {
    List<Specialist> retList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> query =
          await _fireStore.collection('specialists').get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      for (var element in data) {
        if (element.data().containsKey('verified') &&
            element.data().containsKey('at')) {
          if (element.data().containsKey('geo')) {
            Specialist spl = Specialist(
              speciality: element['speciality'],
              location: [...element['location']],
              profile: element['profile'],
              regNo: element['regNo'],
              cert: element['cert'],
              name: element['name'],
              id: element['id'],
              geo: LatLng(
                element['geo'].latitude,
                element['geo'].longitude,
              ),
              verified: element['verified'],
              at: DateTime.fromMillisecondsSinceEpoch(
                  element['at'].seconds * 1000),
            );
            retList.add(spl);
          } else {
            Specialist spl = Specialist(
              speciality: element['speciality'],
              location: [...element['location']],
              profile: element['profile'],
              regNo: element['regNo'],
              cert: element['cert'],
              name: element['name'],
              id: element['id'],
              verified: element['verified'],
              at: DateTime.fromMillisecondsSinceEpoch(
                  element['at'].seconds * 1000),
            );
            retList.add(spl);
          }
        } else {
          if (element.data().containsKey('geo')) {
            Specialist spl = Specialist(
              speciality: element['speciality'],
              location: [...element['location']],
              profile: element['profile'],
              regNo: element['regNo'],
              cert: element['cert'],
              name: element['name'],
              id: element['id'],
              geo: LatLng(
                element['geo'].latitude,
                element['geo'].longitude,
              ),
            );
            retList.add(spl);
          } else {
            Specialist spl = Specialist(
              speciality: element['speciality'],
              location: [...element['location']],
              profile: element['profile'],
              regNo: element['regNo'],
              cert: element['cert'],
              name: element['name'],
              id: element['id'],
            );
            retList.add(spl);
          }
        }
      }
      return retList;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<List<Facility>?> getFacilities() async {
    List<Facility> fcList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> query =
          await _fireStore.collection('facilities').get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      for (var element in data) {
        if (element.data().containsKey('verified') &&
            element.data().containsKey('at')) {
          if (element.data().containsKey('geo')) {
            Facility fc = Facility(
              name: element['name'],
              location: [...element['location']],
              email: element['email'],
              lincenceImg: element['img'],
              lincence: element['lincence'],
              id: element['id'],
              pobox: element['pobox'],
              // geo: LatLng(
              //   element['geo'].latitude,
              //   element['geo'].longitude,
              // ),
              // verified: element['verified'],
              // at: DateTime.fromMillisecondsSinceEpoch(
              //     // element['at'].seconds * 1000),
            );
            fcList.add(fc);
          } else {
            Facility fc = Facility(
              name: element['name'],
              location: [...element['location']],
              email: element['email'],
              lincenceImg: element['img'],
              lincence: element['lincence'],
              id: element['id'],
              pobox: element['pobox'],
              // geo: LatLng(
              //   element['geo'].latitude,
              //   element['geo'].longitude,
              // ),
              // verified: element['verified'],
              // at: DateTime.fromMillisecondsSinceEpoch(
              //     // element['at'].seconds * 1000),
            );
            fcList.add(fc);
          }
        } else {
          if (element.data().containsKey('geo')) {
            Facility fc = Facility(
              name: element['name'],
              location: [...element['location']],
              email: element['email'],
              lincenceImg: element['img'],
              lincence: element['lincence'],
              id: element['id'],
              pobox: element['pobox'],
              // geo: LatLng(
              //   element['geo'].latitude,
              //   element['geo'].longitude,
              // ),
              // verified: element['verified'],
              // at: DateTime.fromMillisecondsSinceEpoch(
              //     // element['at'].seconds * 1000),
            );
            fcList.add(fc);
          } else {
            Facility fc = Facility(
              name: element['name'],
              location: [...element['location']],
              email: element['email'],
              lincenceImg: element['img'],
              lincence: element['lincence'],
              id: element['id'],
              pobox: element['pobox'],
              // geo: LatLng(
              //   element['geo'].latitude,
              //   element['geo'].longitude,
              // ),
              // verified: element['verified'],
              // at: DateTime.fromMillisecondsSinceEpoch(
              //     // element['at'].seconds * 1000),
            );
            fcList.add(fc);
          }
        }
      }
      return fcList;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<List<Facility>?> getVerifiedFacilities() async {
    List<Facility> fcList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> query =
          await _fireStore.collection('facilities').get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      for (var element in data) {
        if (element.data().containsKey('verified') &&
            element.data().containsKey('at')) {
          if (element.data().containsKey('geo')) {
            Facility fc = Facility(
              name: element['name'],
              location: [...element['location']],
              email: element['email'],
              lincenceImg: element['img'],
              lincence: element['lincence'],
              id: element['id'],
              pobox: element['pobox'],
              tests: [...element['tests']],
              geo: LatLng(element['geo'].latitude, element['geo'].longitude),
              verified: element['verified'],
              at: DateTime.fromMillisecondsSinceEpoch(
                  element['at'].seconds * 1000),
            );
            fcList.add(fc);
          } else {
            Facility fc = Facility(
              name: element['name'],
              location: [...element['location']],
              email: element['email'],
              lincenceImg: element['img'],
              lincence: element['lincence'],
              id: element['id'],
              pobox: element['pobox'],
              tests: [...element['tests']],
              verified: element['verified'],
              at: DateTime.fromMillisecondsSinceEpoch(
                  element['at'].seconds * 1000),
            );
            fcList.add(fc);
          }
        }
      }
      return fcList;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<bool> scheduleTest(Test test) async {
    try {
      await _fireStore.collection('tests').doc().set(test.toMap());
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return false;
    }
  }

  Future<bool> updateTest(String testId, String ref) async {
    try {
      await _fireStore.collection('tests').doc(testId).update({
        'ref': ref,
      });
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return false;
    }
  }

  Future<List<Test>?> getTestsOf(String id) async {
    List<Test> retList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> query = await _fireStore
          .collection('tests')
          .where('client', isEqualTo: id)
          .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      for (QueryDocumentSnapshot<Map<String, dynamic>> element in data) {
        Test t = Test(
          client: element['client'],
          facility: element['facility'],
          date: DateTime.fromMillisecondsSinceEpoch(
              element['date'].seconds * 1000),
          type: element['type'],
          ref: element['ref'],
          id: element.id,
        );
        retList.add(t);
      }
      return retList;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<List<Test>?> getTestsOn(String id) async {
    List<Test> retList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> query = await _fireStore
          .collection('tests')
          .where('facility', isEqualTo: id)
          .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      for (QueryDocumentSnapshot<Map<String, dynamic>> element in data) {
        Test t = Test(
          client: element['client'],
          facility: element['facility'],
          date: DateTime.fromMillisecondsSinceEpoch(
              element['date'].seconds * 1000),
          type: element['type'],
          ref: element['ref'],
          id: element.id,
        );
        if (t.ref == 'ref') {
          retList.add(t);
        }
      }
      return retList;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<Test?> getTest(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> tst =
          await _fireStore.collection('tests').doc(id).get();
      if (tst.exists) {
        final dt = tst.data()!;
        Test t = Test(
          client: dt['client'],
          facility: dt['facility'],
          date: DateTime.fromMillisecondsSinceEpoch(dt['date'].seconds * 1000),
          type: dt['type'],
          ref: dt['ref'],
          id: tst.id,
        );
        return t;
      }
      return null;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<List<Specialist>?> getSpecialistsVerified() async {
    List<Specialist> retList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> query =
          await _fireStore.collection('specialists').get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      for (var element in data) {
        if (element.data().containsKey('verified') &&
            element.data().containsKey('at')) {
          if (element.data().containsKey('geo')) {
            Specialist spl = Specialist(
              speciality: element['speciality'],
              location: [...element['location']],
              profile: element['profile'],
              regNo: element['regNo'],
              cert: element['cert'],
              name: element['name'],
              id: element['id'],
              geo: LatLng(element['geo'].latitude, element['geo'].longitude),
              verified: element['verified'],
              at: DateTime.fromMillisecondsSinceEpoch(
                  element['at'].seconds * 1000),
            );
            retList.add(spl);
          } else {
            Specialist spl = Specialist(
              speciality: element['speciality'],
              location: [...element['location']],
              profile: element['profile'],
              regNo: element['regNo'],
              cert: element['cert'],
              name: element['name'],
              id: element['id'],
              verified: element['verified'],
              at: DateTime.fromMillisecondsSinceEpoch(
                  element['at'].seconds * 1000),
            );
            retList.add(spl);
          }
        }
      }
      return retList;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<bool> createTimeTable(TimeTable tmtb) async {
    try {
      await _fireStore.collection('timetables').doc().set(tmtb.toMap());
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return false;
    }
  }

  Future<bool> updateTimeTable(String id) async {
    try {
      await _fireStore.collection('timetables').doc(id).update({
        'available': false,
      });
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return false;
    }
  }

  Future<List<TimeTable>?> getTimeTable(String user, DateTime on) async {
    List<TimeTable> retList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> query = await _fireStore
          .collection('timetables')
          .where('user', isEqualTo: user)
          .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      for (QueryDocumentSnapshot<Map<String, dynamic>> element in data) {
        final st = DateTime.fromMillisecondsSinceEpoch(
            element['start'].seconds * 1000);
        final fn = DateTime.fromMillisecondsSinceEpoch(
            element['finish'].seconds * 1000);
        TimeTable tt = TimeTable(
            start: TimeOfDay.fromDateTime(st),
            finish: TimeOfDay.fromDateTime(fn),
            day: DateTime.fromMillisecondsSinceEpoch(
                element['day'].seconds * 1000),
            user: user,
            available: element['available'],
            id: element.id);
        if (tt.day.compareTo(on) == 0) {
          retList.add(tt);
        }
      }
      return retList;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return retList;
    }
  }

  Future<bool> addUser(User user, String id) async {
    try {
      await _fireStore.collection('users').doc(id).set(user.toMap());
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return false;
    }
  }

  Future<User?> userData(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> data =
          await _fireStore.collection('users').doc(id).get();
      if (data.exists) {
        final map = data.data()!;
        User user = User(
          name: map['name'],
          telephone: map['telephone'],
          email: map['email'],
          at: DateTime.fromMillisecondsSinceEpoch(map['at'].seconds * 1000),
          specialist: map['specialist'],
          facility: map['facility'],
        );
        return user;
      }
      return null;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<Specialist?> specialistData(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> data =
          await _fireStore.collection('specialists').doc(id).get();
      if (data.exists) {
        if (data.data()!.containsKey('verified') &&
            data.data()!.containsKey('at')) {
          final map = data.data()!;
          if (map.containsKey('geo')) {
            Specialist spl = Specialist(
              speciality: map['speciality'],
              location: [...map['location']],
              profile: map['profile'],
              regNo: map['regNo'],
              cert: map['cert'],
              name: map['name'],
              id: map['id'],
              verified: map['verified'],
              at: DateTime.fromMillisecondsSinceEpoch(map['at'].seconds * 1000),
              geo: LatLng(map['geo'].latitude, map['geo'].longitude),
            );
            return spl;
          } else {
            Specialist spl = Specialist(
              speciality: map['speciality'],
              location: [...map['location']],
              profile: map['profile'],
              regNo: map['regNo'],
              cert: map['cert'],
              name: map['name'],
              id: map['id'],
              verified: map['verified'],
              at: DateTime.fromMillisecondsSinceEpoch(map['at'].seconds * 1000),
            );
            return spl;
          }
        } else {
          final map = data.data()!;
          Specialist spl = Specialist(
            speciality: map['speciality'],
            location: [...map['location']],
            profile: map['profile'],
            regNo: map['regNo'],
            cert: map['cert'],
            name: map['name'],
            id: map['id'],
          );
          return spl;
        }
      }
      return null;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<bool> updateUser(String id) async {
    try {
      await _fireStore.collection('users').doc(id).update({
        'specialist': true,
      });
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return false;
    }
  }

  Future<bool> updateUserFacility(String id) async {
    try {
      await _fireStore.collection('users').doc(id).update({
        'facility': true,
      });
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return false;
    }
  }

  Future<bool> verifySpecialist(String id, DateTime at) async {
    try {
      await _fireStore.collection('specialists').doc(id).update({
        'verified': true,
        'at': at,
      });
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return false;
    }
  }

  Future<bool> addGeoData(String id, LatLng latLng) async {
    try {
      final query = await _fireStore
          .collection('facilities')
          .where('id', isEqualTo: id)
          .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      if (data.isNotEmpty) {
        final element = data.first;
        await _fireStore.collection('facilities').doc(element.id).update({
          'geo': GeoPoint(latLng.latitude, latLng.longitude),
        });
        return true;
      }
      return false;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return false;
    }
  }

  Future<bool> addGeoDataUser(String id, LatLng latLng) async {
    try {
      final query = await _fireStore
          .collection('specialists')
          .where('id', isEqualTo: id)
          .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      if (data.isNotEmpty) {
        final element = data.first;
        await _fireStore.collection('specialists').doc(element.id).update({
          'geo': GeoPoint(latLng.latitude, latLng.longitude),
        });
        return true;
      }
      return false;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return false;
    }
  }

  Future<bool> testsOfferedUpdate(String id, List<String> tests) async {
    try {
      final query = await _fireStore
          .collection('facilities')
          .where('id', isEqualTo: id)
          .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      if (data.isNotEmpty) {
        final element = data.first;
        await _fireStore.collection('facilities').doc(element.id).update({
          'tests': tests,
        });
      }
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return false;
    }
  }

  Future<bool> createFacility(Facility fc) async {
    try {
      await _fireStore.collection('facilities').doc().set(fc.toMap());
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return false;
    }
  }

  Future<Facility?> getFacility(String id) async {
    try {
      final query = await _fireStore
          .collection('facilities')
          .where('id', isEqualTo: id)
          .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      if (data.isNotEmpty) {
        final element = data.first;
        if (element.data().containsKey('verified') &&
            element.data().containsKey('at')) {
          if (element.data().containsKey('geo')) {
            Facility fc = Facility(
              name: element.data()['name'],
              location: [...element.data()['location']],
              email: element.data()['email'],
              lincenceImg: element.data()['img'],
              lincence: element.data()['lincence'],
              id: element.data()['id'],
              pobox: element.data()['pobox'],
              tests: [...element['tests']],
              geo: LatLng(element['geo'].latitude, element['geo'].longitude),
              verified: element['verified'],
              at: DateTime.fromMillisecondsSinceEpoch(
                  element['at'].seconds * 1000),
            );
            return fc;
          } else {
            Facility fc = Facility(
              name: element.data()['name'],
              location: [...element.data()['location']],
              email: element.data()['email'],
              lincenceImg: element.data()['img'],
              lincence: element.data()['lincence'],
              id: element.data()['id'],
              pobox: element.data()['pobox'],
              tests: [...element['tests']],
              verified: element['verified'],
              at: DateTime.fromMillisecondsSinceEpoch(
                  element['at'].seconds * 1000),
            );
            return fc;
          }
        } else {
          Facility fc = Facility(
            name: element.data()['name'],
            location: [...element.data()['location']],
            email: element.data()['email'],
            lincenceImg: element.data()['img'],
            lincence: element.data()['lincence'],
            id: element.data()['id'],
            pobox: element.data()['pobox'],
            tests: [...element['tests']],
          );
          return fc;
        }
      }
      return null;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<bool> createSchedule(Schedule sch) async {
    try {
      await _fireStore.collection('schedules').doc().set(sch.toMap());
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return false;
    }
  }

  Future<List<Schedule>?> getSchedulesOf(String id) async {
    List<Schedule> retList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> query =
          await _fireStore.collection('schedules').get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      for (QueryDocumentSnapshot<Map<String, dynamic>> element in data) {
        var sch = Schedule(
          patient: element['patient'],
          specialist: element['specialist'],
          online: element['online'],
          from: DateTime.fromMillisecondsSinceEpoch(
              element['from'].seconds * 1000),
          to: DateTime.fromMillisecondsSinceEpoch(element['to'].seconds * 1000),
          tests: [...element['tests']],
          id: element.id,
        );
        if (sch.patient == id || sch.specialist == id) {
          retList.add(sch);
        }
      }
      return retList;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<List<Schedule>?> getPendingSchedulesOf(String id) async {
    List<Schedule> retList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> query =
          await _fireStore.collection('schedules').get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      for (QueryDocumentSnapshot<Map<String, dynamic>> element in data) {
        var sch = Schedule(
          patient: element['patient'],
          specialist: element['specialist'],
          online: element['online'],
          from: DateTime.fromMillisecondsSinceEpoch(
              element['from'].seconds * 1000),
          to: DateTime.fromMillisecondsSinceEpoch(element['to'].seconds * 1000),
          tests: [...element['tests']],
          id: element.id,
        );
        if (sch.patient == id || sch.specialist == id) {
          final dg = await getDiagnosisByScheduleId(sch.id!);
          if (dg == null) {
            retList.add(sch);
          }
        }
      }
      return retList;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }
}
