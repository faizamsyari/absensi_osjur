import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    final tinggi = MediaQuery.of(context).size.height;
    var obsecure = true.obs;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: tinggi / 30),
            color: Colors.white,
            width: lebar,
            height: tinggi / 3,
            child: Image.asset("images/hima.png", fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: lebar / 20, vertical: tinggi / 20),
            child: TextFormField(
                controller: controller.email,
                cursorColor: Colors.purple,
                decoration: InputDecoration(
                    focusColor: Colors.purple,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple, width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2)),
                    hintText: "Masukkan Alamat Email",
                    hintStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(
                      Icons.mail,
                      color: Colors.black,
                    ))),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: lebar / 20),
              child: Obx(
                (() => TextFormField(
                    controller: controller.password,
                    obscureText: obsecure.value,
                    cursorColor: Colors.purple,
                    decoration: InputDecoration(
                        focusColor: Colors.purple,
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2)),
                        hintText: "Masukkan Password",
                        hintStyle: const TextStyle(color: Colors.black),
                        suffixIcon: IconButton(
                          onPressed: () {
                            obsecure.toggle();
                            print(obsecure.value);
                          },
                          icon: obsecure.value
                              ? const Icon(
                                  Icons.visibility,
                                )
                              : const Icon(Icons.visibility_off),
                          color: Colors.grey,
                        ),
                        prefixIcon: const Icon(
                          Icons.password,
                          color: Colors.black,
                        )))),
              )),
          SizedBox(
            height: tinggi / 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: lebar / 20, vertical: tinggi / 30),
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    fixedSize: MaterialStateProperty.all(
                        Size(lebar / 20, tinggi / 15)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.orange.shade800)),
                onPressed: () {
                  controller.login();
                },
                child: Obx(() {
                  return controller.loading.value == false
                      ? const Text(
                          "Masuk Sekarang",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      : const Text(
                          "Loading....",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        );
                })),
          ),
          const Center(
            child: Text(
              "Created By Faiz Amsyari Rustam",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          SizedBox(
            height: tinggi / 100,
          ),
          const Center(
            child: Text(
              "Tahun 2023",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
