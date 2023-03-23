import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/models.dart';

class FireStoreController extends GetxController {
  final _fireStore = FirebaseFirestore.instance;

  fireStore() {
    return _fireStore;
  }

  Future<List<Specialist>?> getSpecialists() async {
    List<Specialist> retList = [];
    try {
      QuerySnapshot<Map<String, dynamic>> query =
          await _fireStore.collection('specialists').get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = query.docs;
      for (var element in data) {
        Specialist spl = Specialist(
          speciality: element['speciality'],
          location: element['location'],
          profile: element['profile'],
          regNo: element['regNo'],
          cert: element['cert'],
          id: element['id'],
        );
        retList.add(spl);
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
          //at: data.data()!['at'],
          specialist: map['specialist'],
        );
        return user;
      }
      return null;
    } catch (e) {
      //Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }
}
