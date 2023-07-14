import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/halaman_utama_controller.dart';

class HalamanUtamaView extends GetView<HalamanUtamaController> {
  HalamanUtamaView({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    final tinggi = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        drawer: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: controller.dataUser(),
            builder: (context, snapshot) {
              print(snapshot.connectionState);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                return Drawer(
                  child: ListView(
                    children: [
                      DrawerHeader(
                          decoration:
                              BoxDecoration(color: Colors.grey.shade400),
                          child: Row(
                            children: [
                              CircleAvatar(
                                minRadius: 20,
                                maxRadius: 40,
                                child: Image.asset("images/noimage.png"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data?.data()!["nama"],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data?.data()!["nim"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  )
                                ],
                              )
                            ],
                          )),
                      ListTile(
                        onTap: () {
                          Get.toNamed(Routes.PROFILE);
                        },
                        leading: const Icon(Icons.person),
                        title: const Text("Profile Page"),
                      ),
                      ListTile(
                        onTap: () {
                          Get.toNamed(Routes.CLIENT);
                        },
                        leading: const Icon(Icons.qr_code),
                        title: const Text("Presence"),
                      )
                    ],
                  ),
                );
              }
            }),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: lebar / 20),
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: tinggi / 40),
                width: lebar / 20,
                // color: Colors.black,
                child: Row(
                  children: [
                    Material(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          scaffoldKey.currentState!.openDrawer();
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: lebar / 8,
                          height: tinggi / 20,
                          child: const Icon(
                            Icons.menu,
                            color: Colors.black,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: lebar / 30,
                    ),
                    const Text(
                      "Home Page",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                )),
            Container(
              width: lebar,
              // color: Colors.orange,
              padding: EdgeInsets.symmetric(vertical: tinggi / 50),
              child: Row(
                children: [
                  CircleAvatar(
                    minRadius: 30,
                    maxRadius: 45,
                    child: Image.asset("images/noimage.png", fit: BoxFit.cover),
                  ),
                  SizedBox(
                    width: lebar / 15,
                  ),
                  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: controller.data(),
                      builder: (context, sn) {
                        if (sn.connectionState == ConnectionState.active) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Selamat Datang !!",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: tinggi / 100,
                              ),
                              Text(
                                sn.data!.data()!["nama"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: tinggi / 100,
                              ),
                              Text(
                                sn.data!.data()!["nim"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.black),
                              )
                            ],
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      })
                ],
              ),
            ),
            SizedBox(
              height: tinggi / 80,
            ),
            const Text(
              "Nikmati Fitur Aplikasi",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18),
            ),
            SizedBox(
              height: tinggi / 50,
            ),
            GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(
                  vertical: tinggi / 40, horizontal: lebar / 20),
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: lebar / 20,
                  mainAxisSpacing: tinggi / 20),
              itemBuilder: (context, index) {
                late String title;
                late IconData icon;

                switch (index) {
                  case 0:
                    title = "Presensi Sekarang";
                    icon = Icons.qr_code;

                    break;
                  case 1:
                    title = "Profile Account";
                    icon = Icons.person;

                    break;
                  case 2:
                    title = "Detail Presensi";
                    icon = Icons.format_list_bulleted;

                    break;
                  case 3:
                    title = "Logout";
                    icon = Icons.logout;

                    break;
                }
                return Material(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade300,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      if (index == 0) {
                        print("INI 0");
                        Get.toNamed(Routes.CLIENT);
                      } else if (index == 1) {
                        print("INI 1");
                        Get.toNamed(Routes.PROFILE);
                      } else if (index == 2) {
                        Get.toNamed(Routes.ALL_DATA);
                      } else if (index == 3) {
                        controller.signout();
                      }
                    },
                    child: Container(
                      width: lebar / 20,
                      height: tinggi / 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: lebar / 5,
                            height: tinggi / 15,
                            // color: Colors.pink,
                            child: Icon(
                              icon,
                              size: 50,
                            ),
                          ),
                          SizedBox(
                            height: tinggi / 50,
                          ),
                          Text(title)
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
