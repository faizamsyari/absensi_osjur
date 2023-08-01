import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ReadPresenceController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTagihan(
      Map<String, dynamic>? uid) async* {
    print(uid);
    yield* firestore
        .collection("Pengguna")
        .doc(uid?["id"])
        .collection("Presensi")
        .snapshots();
  }

  void deletePresence(Map<String, dynamic> uid, String? tgl) async {
    final ceka = await firestore
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
        .delete();

    final cek = await firestore.collection("rekapan").doc(tgl).get();

    if (ceka.data()?["Status"] == "Izin") {
      await firestore
          .collection("rekapan")
          .doc(tgl)
          .update({"Tidak Hadir": cek.data()?["Tidak Hadir"] + 1});
      await firestore
          .collection("rekapan")
          .doc(tgl)
          .update({"Izin": cek.data()?["Izin"] - 1});
    } else if (ceka.data()?["Status"] == "Sakit") {
      await firestore
          .collection("rekapan")
          .doc(tgl)
          .update({"Tidak Hadir": cek.data()?["Tidak Hadir"] + 1});
      await firestore
          .collection("rekapan")
          .doc(tgl)
          .update({"Sakit": cek.data()?["Sakit"] - 1});
    } else {
      await firestore
          .collection("rekapan")
          .doc(tgl)
          .update({"Tidak Hadir": cek.data()?["Tidak Hadir"] + 1});
      await firestore
          .collection("rekapan")
          .doc(tgl)
          .update({"Hadir": cek.data()?["Hadir"] - 1});
    }
  }
}
