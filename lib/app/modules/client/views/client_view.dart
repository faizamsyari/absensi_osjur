import 'package:absensi_osjur/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/client_controller.dart';

class ClientView extends GetView<ClientController> {
  const ClientView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("BUILD ULANG");
    final lebar = MediaQuery.of(context).size.width;
    final tinggi = MediaQuery.of(context).size.height;
    Map<String, dynamic> lempar = {};
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: lebar / 20, vertical: tinggi / 20),
          children: [
            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: controller.dataUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    print(snapshot.connectionState);
                    return const CircularProgressIndicator();
                  } else {
                    Map<String, dynamic> datauser = snapshot.data!.data()!;
                    lempar = datauser;
                    print("INI DATA USER${lempar}");
                    return Container(
                      width: lebar,
                      child: Column(
                        children: [
                          Container(
                            width: lebar,
                            // height: tinggi / 10,
                            // color: Colors.amber,
                            child: Row(
                              children: [
                                ClipOval(
                                  child: Container(
                                    width: lebar / 5,
                                    height: tinggi / 10,
                                    color: Colors.grey,
                                    child: Image.asset(
                                      "images/noimage.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: lebar / 20,
                                ),
                                SizedBox(
                                  // color: Colors.pink,
                                  width: lebar / 1.6,
                                  // height: tinggi / 15
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Selamat Datang",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: tinggi / 100,
                                      ),
                                      Text(
                                        "${datauser["nama"]}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: tinggi / 100,
                                      ),
                                      Text(
                                        "Kelompok ${datauser["nomorkelompok"]}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: tinggi / 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Material(
                                color: Colors.orange.shade700,
                                borderRadius: BorderRadius.circular(100),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    width: lebar / 8,
                                    height: tinggi / 16,
                                    child: const Icon(
                                      Icons.home,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: lebar / 40,
                              ),
                              Material(
                                color: Colors.orange.shade700,
                                borderRadius: BorderRadius.circular(100),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () => {controller.signout()},
                                  child: Container(
                                    width: lebar / 8,
                                    height: tinggi / 16,
                                    child: const Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: tinggi / 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: tinggi / 40, horizontal: lebar / 20),
                            width: lebar,
                            // height: tinggi / 4,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  datauser["role"] == "client"
                                      ? "Peserta"
                                      : "Panitia",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: tinggi / 50,
                                ),
                                Text(
                                  "${datauser["email"]}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: tinggi / 50,
                                ),
                                Text(
                                  "Kelompok ${datauser["nomorkelompok"]}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: tinggi / 50,
                                ),
                                Text(
                                  "${datauser["nim"]}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
            //
            SizedBox(
              height: tinggi / 20,
            ),
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: controller.today(),
                builder: (context, snaptoday) {
                  if (snaptoday.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    Map<String, dynamic>? datatoday = snaptoday.data?.data();
                    return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: tinggi / 40, horizontal: lebar / 20),
                        width: lebar,
                        // height: tinggi / 4,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Masuk",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Text(
                                  datatoday?["masuk"] != null
                                      ? "${DateFormat.jms().format(DateTime.parse(datatoday?["masuk"]["date"]))}"
                                      : "-",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                )
                              ],
                            ),
                            Container(
                              width: lebar / 100,
                              height: tinggi / 30,
                              color: Colors.black,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Keluar",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Text(
                                  datatoday?["keluar"] != null
                                      ? "${DateFormat.jms().format(DateTime.parse(datatoday?["keluar"]["date"]))}"
                                      : "-",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                )
                              ],
                            )
                          ],
                        ));
                  }
                }),
            SizedBox(
              height: tinggi / 30,
            ),
            const Divider(
              color: Colors.grey,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Riwayat Absensi 2 Terakhir",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.grey)),
                    onPressed: () {
                      Get.toNamed(Routes.ALL_DATA);
                    },
                    child: const Text(
                      "Lihat Semua",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ))
              ],
            ),
            SizedBox(
              height: tinggi / 30,
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.getLastPresence().asBroadcastStream(),
                builder: (context, snappresence) {
                  if (snappresence.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    if (snappresence.data!.docs.length >= 1) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snappresence.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data =
                              snappresence.data!.docs[index].data();
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Masuk",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      data["masuk"] == null
                                          ? "${DateFormat.yMMMEd().format(DateTime.parse(data["tanggal"]))}"
                                          : "${DateFormat.yMMMEd().format(DateTime.parse(data["masuk"]["date"]))}",
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
                                  data["masuk"] != null
                                      ? "${DateFormat.jms().format(DateTime.parse(data["masuk"]!["date"]))}"
                                      : "-",
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
                                  data["keluar"] == null
                                      ? "-"
                                      : "${DateFormat.jms().format(DateTime.parse(data["keluar"]!["date"]))}",
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
                                  data["masuk"] != null
                                      ? "${data["masuk"]["status"]}"
                                      : "-",
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
                                  data["keluar"] == null
                                      ? "-"
                                      : "${data["keluar"]["status"]}",
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
                                  data["Status"] == null
                                      ? "-"
                                      : "${data["Status"]}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      print("Tidak Ada Data");
                      return const Center(
                        child: Text(
                          "Belum Ada Data Presensi",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      );
                    }
                  }
                })
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.orange.shade700,
          label: Row(
            children: [
              const Icon(Icons.qr_code_scanner_sharp),
              Obx(
                () {
                  return controller.loadingabsen.value == false
                      ? const Text("Scan Here")
                      : const Text("Loading....");
                },
              )
            ],
          ),

          onPressed: () {
            controller.ambilLocation(
                lempar["nama"],
                lempar["nomorkelompok"].toString(),
                lempar["email"],
                lempar["role"],
                lempar["nim"]);
          },

          // onPressed: () async {
          //   String responQr = await FlutterBarcodeScanner.scanBarcode(
          //       "#000000", "Kembali", true, ScanMode.QR);
          //   print(responQr);

          //   if (responQr == "ospekjurusanteknikkomputer") {
          //     // Get.snackbar("Selamat", "Absensi Telah Berhasil");
          //     await controller.ambilLocation(
          //       lempar["nama"],
          //       lempar["nomorkelompok"].toString(),
          //       lempar["nim"],
          //       lempar["email"],
          //       lempar["role"],
          //     );
          //   } else {
          //     Get.snackbar(
          //         "Terjadi Kesalahan", "Kode Qr Salah / Gagal Absensi");
          //   }
          // },
        ),
      ),
    );
  }
}
