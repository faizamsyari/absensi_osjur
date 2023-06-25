import 'package:absensi_osjur/app/modules/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:absensi_osjur/app/modules/halaman_utama/controllers/halaman_utama_controller.dart';
import 'package:absensi_osjur/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/modules/blank_pagee/controllers/blank_pagee_controller.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(BlankPageeController(), permanent: true);
  Get.put(HalamanUtamaController(), permanent: true);
  Get.put(BottomNavController(), permanent: true);

  runApp(StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        // return GetMaterialApp(
        //   debugShowCheckedModeBanner: false,
        //   title: "House Pay",
        //   initialRoute: Routes.END_TRANSACTION,
        //   getPages: AppPages.routes,
        // );
        return StreamBuilder(
          stream: BlankPageeController().userRole(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const MaterialApp(
                home: Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            } else {
              print(snap.data);
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: "ABSENSI PKJT",
                initialRoute: snapshot.data != null &&
                        snap.data!.data()!["role"] == "client"
                    ? Routes.BOTTOM_NAV
                    : snapshot.data != null &&
                            snap.data!.data()!["role"] == "panitia"
                        ? Routes.BOTTOM_NAV
                        : snapshot.data != null &&
                                snap.data!.data()!["role"] == "admin"
                            ? Routes.HOME
                            : snapshot.data == null
                                ? Routes.LOGIN
                                : Routes.LOGIN,
                getPages: AppPages.routes,
              );
            }
          },
        );
      }));
}
