import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAccountController extends GetxController {
  RxBool loading = false.obs;
  RxString? role = "".obs;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController passwordAdmin = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void addaccount() async {
    loading.value = true;
    if (email.text.isNotEmpty &&
            password.text.isNotEmpty &&
            role != null &&
            nama.text.isNotEmpty &&
            role?.value == "Peserta"
        ? alamat.text.isNotEmpty
        : alamat.text.isEmpty) {
      print("FUNGSI ADD ACCOUNT DIJALANKAN");
      final dio = Dio();
      if (role?.value == "Peserta") {
        var hasilpost = await dio
            .post("https://kind-plum-ostrich-kilt.cyclic.app/create", data: {
          "email": email.text,
          "password": password.text,
          "nama": nama.text,
          "nim": password.text,
          "alamat": int.parse(alamat.text),
          "role": role?.value == "Peserta" ? "client" : "panitia"
        });
        loading.value = false;
        print(hasilpost.runtimeType);

        if (hasilpost.toString() == "Data Berhasil Didaftarkan") {
          Get.back();
          Get.snackbar("Selamat", "Akun Berhasil Ditambahkan");
        } else {
          print("object");
          Get.snackbar("Terjadi Kesalahan", hasilpost.toString());
        }
      } else {
        var hasilpost = await dio
            .post("https://kind-plum-ostrich-kilt.cyclic.app/create", data: {
          "email": email.text,
          "password": password.text,
          "nama": nama.text,
          "nim": "BUKAN PESERTA",
          "alamat": "BUKAN PESERTA",
          "role": role?.value == "Peserta" ? "client" : "panitia"
        });
        loading.value = false;
        print(hasilpost.runtimeType);

        if (hasilpost.toString() == "Data Berhasil Didaftarkan") {
          Get.back();
          Get.snackbar("Selamat", "Akun Berhasil Ditambahkan");
        } else {
          print("object");
          Get.snackbar("Terjadi Kesalahan", hasilpost.toString());
        }
      }
    } else {
      // ignore: await_only_futures
      await Timer(const Duration(seconds: 3), () {
        loading.value = false;
        print(loading.value);
      });
      Get.snackbar("Terjadi Kesalahan", "Data Tidak Boleh Kosong");
    }
  }

  DropdownSearch dropdownBulan(double lebar, double tinggi) {
    return DropdownSearch<String>(
      popupProps: const PopupProps.menu(
        showSelectedItems: true,
        // disabledItemFn: (String s) => s.startsWith('I'),
      ),
      items: const [
        "Peserta",
        "Panitia",
      ],
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            // contentPadding: EdgeInsets.only(top: tinggi / 80, left: lebar / 40),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            // hintText: "Pilih Role",
            // labelText: "Menu mode",
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple, width: 2)),
            hintText: "Pilih Jabatan",
            prefixIcon: const Icon(
              Icons.date_range,
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
}
