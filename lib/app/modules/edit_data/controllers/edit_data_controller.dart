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
    final cekawal = await firestore
        .collection("Pengguna")
        .doc(uid["id"])
        .collection("Presensi")
        .doc(tgl)
        .get();

    await firestore
        .collection("Pengguna")
        .doc(uid["id"])
        .collection("Presensi")
        .doc(tgl)
        .update({"Status": textmasuk});

    if (textmasuk == "Sakit" && cekawal.data()?["Status"] == "Izin") {
      final ceksakit = await firestore.collection("rekapan").doc(tgl).get();
      await firestore
          .collection("rekapan")
          .doc(tgl)
          .update({"Sakit": ceksakit.data()?["Sakit"] + 1});
      await firestore
          .collection("rekapan")
          .doc(tgl)
          .update({"Izin": ceksakit.data()?["Izin"] - 1});
    } else if (textmasuk == "Izin" && cekawal.data()?["Status"] == "Sakit") {
      final cekizin = await firestore.collection("rekapan").doc(tgl).get();
      await firestore
          .collection("rekapan")
          .doc(tgl)
          .update({"Izin": cekizin.data()?["Izin"] + 1});
      await firestore
          .collection("rekapan")
          .doc(tgl)
          .update({"Sakit": cekizin.data()?["Sakit"] - 1});
    } else if (textmasuk == "Izin" && cekawal.data()?["Status"] == "Hadir") {
      final cekizin = await firestore.collection("rekapan").doc(tgl).get();
      await firestore
          .collection("rekapan")
          .doc(tgl)
          .update({"Izin": cekizin.data()?["Izin"] + 1});
      await firestore
          .collection("rekapan")
          .doc(tgl)
          .update({"Hadir": cekizin.data()?["Hadir"] - 1});
    } else if (textmasuk == "Sakit" && cekawal.data()?["Status"] == "Hadir") {
      final cekizin = await firestore.collection("rekapan").doc(tgl).get();
      await firestore
          .collection("rekapan")
          .doc(tgl)
          .update({"Sakit": cekizin.data()?["Sakit"] + 1});
      await firestore
          .collection("rekapan")
          .doc(tgl)
          .update({"Hadir": cekizin.data()?["Hadir"] - 1});
    } else if (textmasuk == "Hadir" && cekawal.data()?["Status"] == "Sakit") {
      final cekizin = await firestore.collection("rekapan").doc(tgl).get();
      await firestore
          .collection("rekapan")
          .doc(tgl)
          .update({"Hadir": cekizin.data()?["Hadir"] + 1});
      await firestore
          .collection("rekapan")
          .doc(tgl)
          .update({"Sakit": cekizin.data()?["Sakit"] - 1});
    } else if (textmasuk == "Hadir" && cekawal.data()?["Status"] == "Izin") {
      final cekizin = await firestore.collection("rekapan").doc(tgl).get();
      await firestore
          .collection("rekapan")
          .doc(tgl)
          .update({"Izin": cekizin.data()?["Izin"] + 1});
      await firestore
          .collection("rekapan")
          .doc(tgl)
          .update({"Hadir": cekizin.data()?["Hadir"] - 1});
    }
    Get.back();
    Get.snackbar("Selamat !!!", "Data Berhasil Diupdate");
  }
}
