import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ReadPresenceController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTagihan(
      Map<String, dynamic> uid) async* {
    print(uid);
    yield* firestore
        .collection("Pengguna")
        .doc(uid["id"])
        .collection("Presensi")
        .snapshots();
  }
}
