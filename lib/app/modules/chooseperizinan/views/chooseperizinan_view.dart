import 'package:absensi_osjur/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chooseperizinan_controller.dart';

class ChooseperizinanView extends GetView<ChooseperizinanController> {
  const ChooseperizinanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    final tinggi = MediaQuery.of(context).size.height;
    final iddoc = Get.arguments;
    print("INI ID DOC : ${iddoc}");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Perizinan",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.orange.shade800,
        centerTitle: false,
      ),
      body: Center(
        child: Container(
          // color: Colors.orange,
          width: lebar,
          height: tinggi / 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                color: Colors.orange.shade600,
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Get.toNamed(Routes.READ_PRESENCE, arguments: {"id": iddoc});
                  },
                  child: Container(
                    width: lebar / 2.3,
                    height: tinggi / 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.data_exploration_sharp,
                          color: Colors.white,
                          size: 40,
                        ),
                        SizedBox(
                          height: tinggi / 40,
                        ),
                        const Text(
                          "Detail Data Presensi",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: lebar / 20,
              ),
              Material(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Get.toNamed(Routes.PERIZINAN, arguments: iddoc);
                  },
                  child: Container(
                    width: lebar / 2.3,
                    height: tinggi / 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add_a_photo,
                          size: 35,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: tinggi / 40,
                        ),
                        const Text(
                          "Tambahkan Perizinan / Sakit",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
