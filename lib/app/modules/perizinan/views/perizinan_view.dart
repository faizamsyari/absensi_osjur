import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/perizinan_controller.dart';

class PerizinanView extends GetView<PerizinanController> {
  const PerizinanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    final tinggi = MediaQuery.of(context).size.height;
    var obsecure = true.obs;
    final argument = Get.arguments;
    print("INI ARGUMENT PERIZINAN ${argument}");
    var tanggal = DateTime.now().obs;
    var stringtanggal = tanggal.toString();
    print(tanggal.runtimeType);
    print(stringtanggal.runtimeType);
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
            height: tinggi / 5,
            // color: Colors.blue,
            child: Image.asset(
              "images/addakun.png",
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: tinggi / 20,
          ),
          Container(
            width: lebar,
            height: tinggi / 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return Text(
                    DateFormat.yMMMEd().format(tanggal.value),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  );
                }),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          print("TERPRINT");
                          showDatePicker(
                                  helpText: "SILAHKAN PILIH TANGGAL",
                                  context: context,
                                  initialDate: DateTime.parse(stringtanggal),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2045))
                              .then((value) {
                            print(value);
                            if (value != null) {
                              tanggal.value = value;
                            }
                          });
                        },
                        child: const Text(
                          "Edit Tanggal",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        )),
                    const Icon(
                      Icons.calendar_month,
                      color: Colors.red,
                      size: 27,
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: tinggi / 40,
          ),
          controller.dropdownBulan(lebar, tinggi),
          SizedBox(
            height: tinggi / 30,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.orange.shade800),
                  fixedSize:
                      MaterialStateProperty.all(Size(lebar, tinggi / 15))),
              onPressed: () {
                controller.kirimData(argument["id"]);
              },
              child: const Text(
                "Masukkan Data",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
