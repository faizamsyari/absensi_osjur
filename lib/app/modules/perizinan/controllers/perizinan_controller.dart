import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PerizinanController extends GetxController {
  RxString? role = "a".obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DropdownSearch dropdownBulan(double lebar, double tinggi) {
    return DropdownSearch<String>(
      popupProps: const PopupProps.menu(
        showSelectedItems: true,
        // disabledItemFn: (String s) => s.startsWith('I'),
      ),
      items: const [
        "Sakit",
        "Izin",
      ],
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            // contentPadding: EdgeInsets.only(top: tinggi / 80, left: lebar / 40),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            // hintText: "Pilih Role",
            // labelText: "Menu mode",
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple, width: 2)),
            hintText: "Pilih Perizinan",
            prefixIcon: const Icon(
              Icons.data_saver_on_rounded,
              color: Colors.purple,
            )),
      ),
      onChanged: (halo) {
        print(halo);
        role?.value = halo!;
        print("INI ROLE OBS = ${role?.value}");
      },
    );
  }

  void kirimData(String id) async {
    DateTime tgl = DateTime.now();
    String datenow = DateFormat.yMd().format(tgl).replaceAll("/", "-");
    print(role?.value);
    if (role?.value == "a") {
      print("Data Kosong");
      Get.snackbar("Terjadi Kesalahan", "Data Tidak Boleh Kosong");
    } else {
      try {
        print("Jalankan Pengiriman Data");
        var getStatus = await firestore
            .collection("Pengguna")
            .doc(id)
            .collection("Presensi")
            .doc(datenow)
            .get();
        if (getStatus.data()?["Status"] != null) {
          Get.defaultDialog(
              title: "Apakah Anda Ingin Mengganti Status Perizinan?",
              middleText:
                  "Silahkan Klik Konfirmasi Jika Ingin Mengganti Perizinan",
              cancel: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Back")),
              confirm: TextButton(
                  onPressed: () async {
                    // var colUser = await firestore
                    //     .collection("Pengguna")
                    //     .doc(id)
                    //     .collection("Presensi")
                    //     .doc(datenow)
                    //     .set({"Status": role!.value});

                    // var get = await firestore
                    //     .collection("rekapan")
                    //     .doc(datenow)
                    //     .get();
                    // if (get.exists) {
                    //   if (role?.value == "Sakit") {
                    //     if (get.data()?["Sakit"] != null) {
                    //       var colRekap = await firestore
                    //           .collection("rekapan")
                    //           .doc(datenow)
                    //           .update({"Sakit": get.data()?["Sakit"] + 1});
                    //     } else {
                    //       var colRekap = await firestore
                    //           .collection("rekapan")
                    //           .doc(datenow)
                    //           .update({"Sakit": 1});
                    //     }
                    //   } else {
                    //     if (get.data()?["Izin"] != null) {
                    //       var colRekap = await firestore
                    //           .collection("rekapan")
                    //           .doc(datenow)
                    //           .update({"Izin": get.data()?["Izin"] + 1});
                    //     } else {
                    //       var colRekap = await firestore
                    //           .collection("rekapan")
                    //           .doc(datenow)
                    //           .update({"Izin": 1});
                    //     }
                    //   }
                    // } else {
                    //   await firestore
                    //       .collection("rekapan")
                    //       .doc(datenow)
                    //       .update({
                    //     "Sakit": 0,
                    //     "Izin": 0,
                    //     "Hadir": 0,
                    //     "Waktu": datenow
                    //   });
                    // }
                    Get.back();
                    Get.snackbar("Mohon Maaf", "Perizinan Ada Sebelumnya");
                  },
                  child: Text("Konfirmasi")));
        } else {
          await firestore
              .collection("Pengguna")
              .doc(id)
              .collection("Presensi")
              .doc(datenow)
              .set({"Status": role!.value});
          var cek = await firestore.collection("rekapan").doc(datenow).get();
          if (cek.exists) {
            if (role?.value == "Sakit") {
              if (cek.data()?["Sakit"] != null) {
                await firestore
                    .collection("rekapan")
                    .doc(datenow)
                    .update({"Sakit": cek.data()?["Sakit"] + 1});
              } else {
                await firestore
                    .collection("rekapan")
                    .doc(datenow)
                    .update({"Sakit": 1});
              }
            } else {
              if (cek.data()?["Izin"] != null) {
                await firestore
                    .collection("rekapan")
                    .doc(datenow)
                    .update({"Izin": cek.data()?["Izin"] + 1});
              } else {
                await firestore
                    .collection("rekapan")
                    .doc(datenow)
                    .update({"Izin": 1});
              }
            }
          } else {
            await firestore.collection("rekapan").doc(datenow).set({
              "Sakit": 0,
              "Izin": 0,
              "Hadir": 0,
              "Tidak Hadir": 35,
              "Waktu": datenow,
              "tanggal": DateTime.now().toIso8601String()
            });
          }

          Get.snackbar("Selamat", "Perizinan Telah Dibuat");
        }
      } catch (e) {
        Get.snackbar('Terjadi Kesalahan', "Silahkan Coba Lagi Nanti");
      }
    }
  }
}
