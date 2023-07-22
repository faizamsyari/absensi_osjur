// ignore_for_file: avoid_unnecessary_containers, unnecessary_string_interpolations

import 'package:absensi_osjur/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/read_presence_controller.dart';

class ReadPresenceView extends GetView<ReadPresenceController> {
  const ReadPresenceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    final tinggi = MediaQuery.of(context).size.height;
    Map<String, dynamic> argument = Get.arguments;
    print("INI ARGUMENT READ PRESENCE ${argument["id"]}");
    return SafeArea(
      child: Scaffold(
          body: ListView(
        padding: EdgeInsets.symmetric(vertical: tinggi / 30),
        children: [
          Padding(
            padding: EdgeInsets.only(left: lebar / 30),
            child: Row(
              children: [
                Material(
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: lebar / 10,
                      height: tinggi / 20,
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                SizedBox(
                  width: lebar / 30,
                ),
                const Text(
                  "Halaman Detail Presensi",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.streamTagihan(argument["id"]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data?.docs.length,
                    padding: EdgeInsets.symmetric(
                        horizontal: lebar / 20, vertical: tinggi / 40),
                    itemBuilder: (context, index) {
                      Map<String, dynamic>? data =
                          snapshot.data?.docs[index].data();
                      String? datatgl = snapshot.data?.docs[index].id;
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: tinggi / 40, horizontal: lebar / 20),
                        margin: EdgeInsets.only(bottom: tinggi / 20),
                        width: lebar,
                        // height: tinggi / 20,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Masuk",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                                Text(
                                  data?["masuk"]?["date"] == null
                                      ? "-"
                                      : "${DateFormat.yMMMEd().format(DateTime.parse(data!["masuk"]["date"]))}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: tinggi / 80,
                            ),
                            Text(
                              data?["masuk"] == null
                                  ? "-"
                                  : "${DateFormat.jms().format(DateTime.parse(data?["masuk"]["date"]))}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: tinggi / 70,
                            ),
                            const Text(
                              "Keluar",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: tinggi / 80,
                            ),
                            Text(
                              data?["keluar"]?["date"] == null
                                  ? "-"
                                  : "${DateFormat.jms().format(DateTime.parse(data?["keluar"]!["date"]))}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: tinggi / 80,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Status Absensi Masuk",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                                Container(
                                  width: lebar / 3,
                                  // color: Colors.amber,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(Routes.EDIT_DATA,
                                              arguments: {
                                                "tgl": datatgl,
                                                "uid": argument["id"],
                                                "status": data?["Status"]
                                              });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: lebar / 60,
                                              vertical: tinggi / 60),
                                          decoration: BoxDecoration(
                                              color: Colors.orange.shade700,
                                              shape: BoxShape.circle),
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: lebar / 30,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          controller.deletePresence(
                                              argument["id"], datatgl);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: lebar / 60,
                                              vertical: tinggi / 60),
                                          decoration: BoxDecoration(
                                              color: Colors.red.shade700,
                                              shape: BoxShape.circle),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: tinggi / 80,
                            ),
                            Text(
                              data?["masuk"] == null
                                  ? "-"
                                  : "${data?["masuk"]["status"]}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: tinggi / 70,
                            ),
                            const Text(
                              "Status Absensi Keluar",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: tinggi / 80,
                            ),
                            Text(
                              data?["keluar"] == null
                                  ? "-"
                                  : "${data?["keluar"]["status"]}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: tinggi / 70,
                            ),
                            const Text(
                              "Status Kehadiran",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: tinggi / 80,
                            ),
                            Text(
                              data?["Status"] == null
                                  ? "-"
                                  : "${data?["Status"]}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              })
        ],
      )),
    );
  }
}
