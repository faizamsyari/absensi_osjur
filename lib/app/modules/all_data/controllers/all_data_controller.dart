import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AllDataController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> allPresence() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("Pengguna")
        .doc(uid)
        .collection("Presensi")
        .orderBy("tanggal", descending: true)
        .snapshots();
  }
}
