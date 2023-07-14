import 'package:absensi_osjur/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_admin_controller.dart';

class DetailAdminView extends GetView<DetailAdminController> {
  const DetailAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    final tinggi = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: Colors.grey.shade500,
            title: const Text(
              "Detail Presensi",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: lebar / 20, vertical: tinggi / 20),
            children: [
              SizedBox(
                height: tinggi / 40,
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.getUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic>? data =
                              snapshot.data?.docs[index].data();

                          //
                          var email =
                              snapshot.data!.docs[index].data()["email"];
                          String emailku = email;
                          var emailsub = (emailku.length < 23)
                              ? emailku
                              : emailku.substring(0, 23);
                          print(emailsub);
                          var nama = snapshot.data!.docs[index].data()["nama"];
                          String string = nama;
                          var namasub = (string.length < 18)
                              ? string
                              : string.substring(0, 16);
                          print(namasub);
                          return Padding(
                            padding: EdgeInsets.only(bottom: tinggi / 40),
                            child: Material(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(15),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: (() {
                                  Get.toNamed(Routes.CHOOSEPERIZINAN,
                                      arguments: {"id": data?["id"]});
                                  // Get.toNamed(Routes.READ_PRESENCE,
                                  //     arguments: {"id": data?["id"]});
                                }),
                                child: Container(
                                    width: lebar,
                                    height: tinggi / 8,
                                    decoration: const BoxDecoration(
                                        // color: Colors.blue.shade300,
                                        ),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.only(left: lebar / 50),
                                          width: lebar / 9,
                                          height: tinggi / 5,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                          child:
                                              Image.asset("images/noimage.png"),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: lebar / 20,
                                                  right: lebar / 20),
                                              child: Text(
                                                emailsub,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            SizedBox(
                                              height: tinggi / 100,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: lebar / 20,
                                                  right: lebar / 20),
                                              child: Text(
                                                namasub,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  })
            ],
          )),
    );
  }
}
