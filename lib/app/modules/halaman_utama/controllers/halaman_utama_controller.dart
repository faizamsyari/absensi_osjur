import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HalamanUtamaController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void signout() async {
    await auth.signOut();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> dataUser() async {
    String uid = auth.currentUser!.uid;
    print("DI BUILD ULANG NGABB");
    return firestore.collection("Pengguna").doc(uid).get();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> data() async* {
    String uid = auth.currentUser!.uid;
    print("DI BUILD ULANG NGABB");
    yield* firestore.collection("Pengguna").doc(uid).snapshots();
  }
}
