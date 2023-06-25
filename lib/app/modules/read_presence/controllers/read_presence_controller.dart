import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ReadPresenceController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTagihan(String uid) async* {
    print(uid);
    yield* firestore
        .collection("Pengguna")
        .doc(uid)
        .collection("Presensi")
        .snapshots();
  }
}
