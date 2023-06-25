import 'package:absensi_osjur/app/modules/halaman_utama/views/halaman_utama_view.dart';
import 'package:absensi_osjur/app/modules/profile/views/profile_view.dart';
import 'package:absensi_osjur/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bottom_nav_controller.dart';

class BottomNavView extends GetView<BottomNavController> {
  const BottomNavView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final kumpulanScreen = [
      HalamanUtamaView(),
      const ProfileView(),
    ];
    return Scaffold(
        body: Obx(
          () => kumpulanScreen[controller.selectedIndex.value],
        ),
        backgroundColor: Colors.grey[200],
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange[900],
          child: const Icon(Icons.qr_code_2_rounded),
          onPressed: () {
            Get.toNamed(Routes.CLIENT);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Obx(() => BottomNavigationBar(
                backgroundColor: Colors.white,
                //fixedColor: Colors.orange[900],
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.orange,
                unselectedItemColor: Colors.black,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                onTap: (index) {
                  controller.changeIndex(index);
                  print(index);
                },
                currentIndex: controller.selectedIndex.value,
                items: const [
                  BottomNavigationBarItem(
                      tooltip: "Beranda",
                      icon: Icon(
                        Icons.home,
                        //color: Colors.red,
                      ),
                      label: 'Beranda'),
                  BottomNavigationBarItem(
                      tooltip: "Profil",
                      icon: Icon(Icons.person),
                      label: 'Profil',
                      backgroundColor: Colors.red),
                ])));
  }
}
