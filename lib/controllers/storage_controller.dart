import 'dart:io';

import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageController extends GetxController {
  final _storageRef = FirebaseStorage.instance.ref();

  storage() {
    return _storageRef;
  }

  Future<String?> upLoadCert(File file, String name) async {
    try {
      await _storageRef.child('certs/$name').putFile(file);
      String url = await _storageRef.child('certs/$name').getDownloadURL();
      return url;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }

  Future<String?> upLoadTestImg(File file, String name) async {
    try {
      await _storageRef.child('tests/$name').putFile(file);
      String url = await _storageRef.child('tests/$name').getDownloadURL();
      return url;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }

  Future<String?> upLoadLincence(File file, String name) async {
    try {
      await _storageRef.child('lincences/$name').putFile(file);
      String url = await _storageRef.child('lincences/$name').getDownloadURL();
      return url;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }

  Future<String?> upLoadProfile(File file, String name) async {
    try {
      await _storageRef.child('profiles/$name').putFile(file);
      String url = await _storageRef.child('profiles/$name').getDownloadURL();
      return url;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }
}
