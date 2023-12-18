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

  Future<bool> createRequest(Request req) async {
    try {
      await _fireStore.collection('requests').doc().set(req.toMap());
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return false;
    }
  }

  Future<List<Request>?> getRequests() async {
    List<Request> retList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> query =
          await _fireStore.collection('requests').get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      // DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch)

      for (var element in data) {
        Request spl = Request(
          specialist: element['specialist'],
          patient: element['patient'],
          online: element['online'],
          time:
              DateTime.fromMillisecondsSinceEpoch(element['at'].seconds * 1000),
          adjusted: DateTime.fromMillisecondsSinceEpoch(
              element['adjusted']!.seconds * 1000),
        );
        retList.add(spl);
      }
      return retList;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<List<Request>?> getRequestsOf(String id) async {
    List<Request> retList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> query = await _fireStore
          .collection('requests')
          .where('pending', isEqualTo: true)
          .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      // DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch)

      for (QueryDocumentSnapshot<Map<String, dynamic>> element in data) {
        Request spl;
        if (element.data().containsKey('adjusted')) {
          spl = Request(
            specialist: element['specialist'],
            patient: element['patient'],
            online: element['online'],
            time: DateTime.fromMillisecondsSinceEpoch(
                element['at'].seconds * 1000),
            adjusted: DateTime.fromMillisecondsSinceEpoch(
                element['adjusted'].seconds * 1000),
            id: element.id,
          );
        } else {
          spl = Request(
            specialist: element['specialist'],
            patient: element['patient'],
            online: element['online'],
            time: DateTime.fromMillisecondsSinceEpoch(
                element['at'].seconds * 1000),
            id: element.id,
          );
        }
        if (spl.patient == id || spl.specialist == id) {
          retList.add(spl);
        }
      }
      return retList;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<List<Request>?> getAllRequestsOf(String id) async {
    List<Request> retList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> query =
          await _fireStore.collection('requests').get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      // DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch)

      for (QueryDocumentSnapshot<Map<String, dynamic>> element in data) {
        Request spl;
        if (element.data().containsKey('adjusted')) {
          spl = Request(
            specialist: element['specialist'],
            patient: element['patient'],
            online: element['online'],
            time: DateTime.fromMillisecondsSinceEpoch(
                element['at'].seconds * 1000),
            adjusted: DateTime.fromMillisecondsSinceEpoch(
                element['adjusted'].seconds * 1000),
            id: element.id,
          );
        } else {
          spl = Request(
            specialist: element['specialist'],
            patient: element['patient'],
            online: element['online'],
            time: DateTime.fromMillisecondsSinceEpoch(
                element['at'].seconds * 1000),
            id: element.id,
          );
        }
        if (spl.patient == id || spl.specialist == id) {
          retList.add(spl);
        }
      }
      return retList;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<List<Request>?> getAllRequestsMadeBy(String id) async {
    List<Request> retList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> query =
          await _fireStore.collection('requests').get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      // DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch)

      for (QueryDocumentSnapshot<Map<String, dynamic>> element in data) {
        Request spl;
        if (element.data().containsKey('adjusted')) {
          spl = Request(
            specialist: element['specialist'],
            patient: element['patient'],
            online: element['online'],
            time: DateTime.fromMillisecondsSinceEpoch(
                element['at'].seconds * 1000),
            adjusted: DateTime.fromMillisecondsSinceEpoch(
                element['adjusted'].seconds * 1000),
            id: element.id,
          );
        } else {
          spl = Request(
            specialist: element['specialist'],
            patient: element['patient'],
            online: element['online'],
            time: DateTime.fromMillisecondsSinceEpoch(
                element['at'].seconds * 1000),
            id: element.id,
          );
        }
        if (spl.patient == id) {
          retList.add(spl);
        }
      }
      return retList;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<bool> approveRequest(String id, Schedule sch) async {
    try {
      await _fireStore.collection('requests').doc(id).update({
        'pending': false,
        'ok': true,
      });
      return await createSchedule(sch);
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return false;
    }
  }

  Future<bool> editRequest(String id, DateTime adjusted) async {
    try {
      await _fireStore.collection('requests').doc(id).update({
        'adjusted': adjusted,
      });
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return false;
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
      await _fireStore.collection('specialists').doc(id).update({
        'geo': GeoPoint(latLng.latitude, latLng.longitude),
      });
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
          time:
              DateTime.fromMillisecondsSinceEpoch(element['at'].seconds * 1000),
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
}
