import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double Lebar = MediaQuery.of(context).size.width;
    double Tinggi = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: const Text("Profile Page"),
          backgroundColor: Colors.orange.shade700,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: Lebar / 20),
          children: [
            Column(
              children: [
                SizedBox(
                  height: Tinggi / 30,
                ),
                Container(
                  padding: EdgeInsets.only(left: Lebar / 10, right: Lebar / 10),
                  width: Lebar / 2.5,
                  height: Tinggi / 4,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("images/noimage.png"),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: Tinggi / 30,
                ),
                const Text(
                  "Faiz Amyari Rustam",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: Tinggi / 50,
                ),
                const Text(
                  "akundummy@hmtk.com",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.black),
                ),
                SizedBox(
                  height: Tinggi / 30,
                ),
                ListTile(
                  onTap: () {
                    // print(controller.halo());
                  },
                  leading: const Icon(
                    Icons.system_update_alt_rounded,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Update Status",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                  trailing: const Icon(
                    Icons.arrow_right_sharp,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Change Profile",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                  trailing: const Icon(
                    Icons.arrow_right_sharp,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.color_lens,
                      color: Colors.black,
                    ),
                    title: const Text(
                      "Change Theme",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                    trailing: const Text(
                      "Light ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )),
              ],
            )
          ],
        ));
  }
}
