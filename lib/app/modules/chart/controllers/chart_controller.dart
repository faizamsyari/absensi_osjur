import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChartController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> rekapData() async* {
    yield* firestore
        .collection("rekapan")
        .orderBy("tanggal", descending: false)
        .snapshots();
  }
}
