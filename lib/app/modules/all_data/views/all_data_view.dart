// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_const, prefer_const_constructors, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/all_data_controller.dart';

class AllDataView extends GetView<AllDataController> {
  const AllDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    final tinggi = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Presense View'),
          backgroundColor: Colors.grey,
          centerTitle: false,
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.allPresence(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  padding: EdgeInsets.symmetric(
                      horizontal: lebar / 20, vertical: tinggi / 40),
                  itemBuilder: (context, index) {
                    Map<String, dynamic>? data =
                        snapshot.data?.docs[index].data();
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
                            "${DateFormat.jms().format(DateTime.parse(data?["masuk"]!["date"]))}",
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
                                : "${DateFormat.jms().format(DateTime.parse(data!["keluar"]!["date"]))}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: tinggi / 70,
                          ),
                          const Text(
                            "Status Absensi Masuk",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: tinggi / 80,
                          ),
                          Text(
                            data?["masuk"] == null
                                ? "-"
                                : "${data?["masuk"]["status"]}",
                            style: TextStyle(
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
                          )
                        ],
                      ),
                    );
                  },
                );
              }
            }));
  }
}
