import 'dart:async';

import 'package:absensi_osjur/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool loading = false.obs;

  Future<void> login() async {
    loading.value = true;
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      print("SEMUA TERISI DENGAN BAIK");
      try {
        final credential = await auth.signInWithEmailAndPassword(
            email: email.text, password: password.text);
        print(credential);
        final data = await firestore
            .collection("Pengguna")
            .doc(credential.user!.uid)
            .get();
        print(data.data()!["role"]);

        if (data.data()!["role"] == "client" ||
            data.data()!["role"] == "panitia") {
          print("INI ADALAH CLIENT");
          loading.value = false;

          Get.offAllNamed(Routes.BOTTOM_NAV);
        } else {
          loading.value = false;

          Get.offAllNamed(Routes.HOME);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          // ignore: await_only_futures
          await Timer(const Duration(seconds: 5), () {
            loading.value = false;
          });
          Get.snackbar("Terjadi Kesalahan !!!", "Email Tidak Valid");
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          // ignore: await_only_futures
          await Timer(const Duration(seconds: 5), () {
            loading.value = false;
            print(loading.value);
          });

          Get.snackbar("Terjadi Kesalahan !!!", "Password Salah");
        }
      }
    } else {
      print("Data Tidak Boleh Kosong");
      // ignore: await_only_futures
      await Timer(const Duration(seconds: 5), () {
        loading.value = false;
        print(loading.value);
      });

      Get.snackbar("Error", "Email / Password Tidak Boleh Kosong");
    }
  }
}
