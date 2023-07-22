import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditDataController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void editData(
    Map<String, dynamic> uid,
    String? tgl,
    var textmasuk,
  ) async {
    await firestore
        .collection("Pengguna")
        .doc(uid["id"])
        .collection("Presensi")
        .doc(tgl)
        .update({"Status": textmasuk});
    Get.back();
    Get.snackbar("Selamat !!!", "Data Berhasil Diupdate");
  }
}
