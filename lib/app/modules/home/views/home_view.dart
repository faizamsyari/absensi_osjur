import 'package:absensi_osjur/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    final tinggi = MediaQuery.of(context).size.height;

    // final List<chartSakit> chartS = [];
    return SafeArea(
      child: Scaffold(
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: tinggi / 20,
            ),
            GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(
                  vertical: tinggi / 20, horizontal: lebar / 20),
              itemCount: 5,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: lebar / 20,
                  mainAxisSpacing: tinggi / 20),
              itemBuilder: (context, index) {
                late String title;
                late IconData icon;

                switch (index) {
                  case 0:
                    title = "Tambahkan Akun";
                    icon = Icons.post_add_outlined;

                    break;
                  case 1:
                    title = "Detail Absensi";
                    icon = Icons.list_alt_outlined;

                    break;
                  case 2:
                    title = "Download Absensi";
                    icon = Icons.download;

                    break;
                  case 3:
                    title = "Simpan Di Spreadsheet";
                    icon = Icons.edit_document;

                    break;
                  case 4:
                    title = "Lihat Grafik Rekapan Data";
                    icon = Icons.line_axis_outlined;

                    break;
                }
                return Material(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade300,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () async {
                      if (index == 0) {
                        print("INI 0");
                        Get.toNamed(Routes.ADD_ACCOUNT);
                      } else if (index == 1) {
                        print("INI 1");
                        Get.toNamed(Routes.DETAIL_ADMIN);
                      } else if (index == 2) {
                        controller.downloadPdf();
                      } else if (index == 3) {
                        controller.downloadexcel();
                      } else if (index == 4) {
                        Get.toNamed(Routes.CHART);
                      }
                    },
                    child: Container(
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey,
          child: const Icon(Icons.logout, size: 25),
          onPressed: () {
            controller.logout();
          },
        ),
      ),
    );
  }
}
