import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_data_controller.dart';

class EditDataView extends GetView<EditDataController> {
  const EditDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    final tinggi = MediaQuery.of(context).size.height;
    final argument = Get.arguments;
    TextEditingController absenmasuk =
        TextEditingController(text: argument["status"]);

    print(argument);
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
              controller: absenmasuk,
              cursorColor: Colors.purple,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.login,
                    color: Colors.purple,
                  ),
                  hintText: "Status Absensi Masuk",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2))),
            ),
            SizedBox(
              height: tinggi / 30,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    fixedSize:
                        MaterialStateProperty.all(Size(lebar, tinggi / 20)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.orange.shade700)),
                onPressed: () {
                  controller.editData(
                      argument["uid"], argument["tgl"], absenmasuk.text);
                },
                child: const Text("Edit Data Presensi",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)))
          ],
        ));
  }
}
