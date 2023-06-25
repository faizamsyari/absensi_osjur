import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_account_controller.dart';

class AddAccountView extends GetView<AddAccountController> {
  const AddAccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    final tinggi = MediaQuery.of(context).size.height;
    var obsecure = true.obs;

    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: EdgeInsets.only(
              left: lebar / 20, right: lebar / 20, top: tinggi / 8),
          children: [
            SizedBox(
              width: lebar,
              height: tinggi / 20,
              // color: Colors.amber,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 27,
                      ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: tinggi / 30),
              width: lebar / 20,
              height: tinggi / 8,
              // color: Colors.blue,
              child: Image.asset(
                "images/addakun.png",
                fit: BoxFit.contain,
              ),
            ),
            TextField(
              controller: controller.email,
              cursorColor: Colors.purple,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.purple,
                  ),
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2))),
            ),
            SizedBox(
              height: tinggi / 40,
            ),
            Obx(
              () {
                return TextField(
                  controller: controller.password,
                  obscureText: obsecure.value,
                  cursorColor: Colors.purple,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          obsecure.toggle();
                          print(obsecure.value);
                        },
                        icon: obsecure.value
                            ? const Icon(
                                Icons.visibility_off,
                              )
                            : const Icon(Icons.visibility),
                        color: Colors.grey,
                      ),
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Colors.purple,
                      ),
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2))),
                );
              },
            ),
            SizedBox(
              height: tinggi / 40,
            ),
            TextField(
              controller: controller.nama,
              cursorColor: Colors.purple,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.purple,
                  ),
                  hintText: "Nama Lengkap",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2))),
            ),
            SizedBox(
              height: tinggi / 40,
            ),
            controller.dropdownBulan(lebar, tinggi),
            SizedBox(
              height: tinggi / 40,
            ),
            Obx(
              () {
                return controller.role?.value == "Peserta"
                    ? TextField(
                        controller: controller.alamat,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.purple,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.group,
                              color: Colors.purple,
                            ),
                            hintText: "Nomor Kelompok",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2))),
                      )
                    : const SizedBox(
                        height: 2,
                      );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: lebar / 20, vertical: tinggi / 20),
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                      fixedSize: MaterialStateProperty.all(
                          Size(lebar / 20, tinggi / 15)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange.shade800)),
                  onPressed: () {
                    controller.addaccount();
                  },
                  child: Obx(() {
                    return controller.loading.value == false
                        ? const Text(
                            "Tambahkan Akun",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        : const Text(
                            "Loading...",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          );
                  })),
            )
          ],
        ));
  }
}
