import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BlankPageeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> userRole() async* {
    String uid = auth.currentUser!.uid;
    print("INI UID $uid");

    yield* firestore.collection("Pengguna").doc(uid).snapshots();
  }
}
