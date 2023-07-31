// ignore_for_file: await_only_futures

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import 'package:intl/intl.dart';

class ClientController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String uidabsen = "";
  RxBool loadingabsen = false.obs;

  void signout() async {
    await auth.signOut();
  }

  Future<void> ambilLocation(String nama, String nomor, String email,
      String statusjabatananda, String nim) async {
    loadingabsen.value == true;
    print("Absensi Dijalankan");
    Map<String, dynamic> dataLoc = await determinePosition();
    if (dataLoc["error"] == true) {
      Get.snackbar("Terjadi Kesalahan", "${dataLoc["message"]}");
    } else {
      Position position = dataLoc["position"];
      print("${position.latitude}, ${position.longitude}");
      Get.snackbar("${dataLoc["message"]}",
          "${position.latitude}, ${position.longitude}");
      double distance = Geolocator.distanceBetween(
          -7.3112662, 112.7247646, position.latitude, position.longitude);
      // if (distance <= 1000) {
      //   await presensiPeserta(
      //       position, nama, nomor, email, statusjabatananda, nim);
      //   loadingabsen.value = false;
      // } else {
      //   Get.snackbar("Terjadi Kesalahan",
      //       "Gagal Absen Anda Tidak Berada Dalam Area Jangkauan");
      //   loadingabsen.value = false;
      // }
      await presensiPeserta(
          position, nama, nomor, email, statusjabatananda, nim);
    }
    loadingabsen.value = false;

    print("Absensi Selesai ");
  }

  Future<void> presensiPeserta(Position position, String nama, String nomor,
      String nim, String email, String statusjabatananda) async {
    loadingabsen.value = true;
    String uid = await auth.currentUser!.uid;
    print("INI UID PRESENSI $uid");
    //ambil rolenya
    var role = await firestore.collection("Pengaturan").doc("1").get();

    print(role.data());
    //logika jam
    var jammasukpanitia = "${role.data()!["panitia"]["jammasuk"]}";
    var jamkeluarpanitia = "${role.data()!["panitia"]["jamkeluar"]}";
    var jammasukpeserta = "${role.data()!["peserta"]["jammasuk"]}";
    var jamkeluarpeserta = "${role.data()!["peserta"]["jamkeluar"]}";

    var roleuser = await firestore.collection("Pengguna").doc(uid).get();
    print(roleuser.data());
    var waktu = DateFormat.Hm().format(DateTime.now());
    print(waktu.runtimeType);
    print(waktu);
    int convertnow = int.parse(waktu.replaceAll(":", ""));
    int convert = int.parse(roleuser.data()!["role"] == "client"
        ? jammasukpeserta.replaceAll(":", "")
        : jammasukpanitia.replaceAll(":", ""));
    int convertnw = int.parse(roleuser.data()!["role"] == "client"
        ? jamkeluarpeserta.replaceAll(":", "")
        : jamkeluarpanitia.replaceAll(":", ""));
    print(convert);
    print(convert.runtimeType);
    print(convertnow);
    print(convertnow.runtimeType);
    //
    QuerySnapshot<Map<String, dynamic>> cek = await firestore
        .collection("Pengguna")
        .doc(uid)
        .collection("Presensi")
        .get();
    DateTime now = DateTime.now();
    String datenow = DateFormat.yMd().format(now).replaceAll("/", "-");
    print(datenow);
    print(cek.docs.length);

    var cekkehadiran = await firestore
        .collection("Pengguna")
        .doc(uid)
        .collection("Presensi")
        .doc(datenow)
        .get();

    if (cekkehadiran.data()?["Status"] == "Sakit" ||
        cekkehadiran.data()?["Status"] == "Izin") {
      Get.snackbar(
          "Terjadi Kesalahan", "ANDA TELAH DIIZINKAN DAN TIDAK PERLU ABSEN");
    } else {
      if (cek.docs.isEmpty) {
        //belum pernah absen dan set absen masuk
        if (convertnow >= convert) {
          print("Anda Terlambat");
          var absen = await firestore
              .collection("Pengguna")
              .doc(uid)
              .collection("Presensi")
              .doc(datenow)
              .set({
            "tanggal": now.toIso8601String(),
            "nama": nama,
            "nomor": nomor,
            "role": statusjabatananda,
            "nim": nim,
            "email": email,
            "idclient": uid,
            "waktu": datenow,
            "masuk": {
              "date": now.toIso8601String(),
              "latitude": position.latitude,
              "longitude": position.longitude,
              "status": "Terlambat Masuk"
            }
          });
          var idadmin = await firestore.collection("Admin").add({
            "nama": nama,
            "nomor": nomor,
            "role": statusjabatananda,
            "email": email,
            "nim": nim,
            "tanggal": now.toIso8601String(),
            "idclient": uid,
            "waktu": datenow,
            "masuk": {
              "date": now.toIso8601String(),
              "latitude": position.latitude,
              "longitude": position.longitude,
              "status": "Terlambat Masuk"
            }
          });

          await firestore
              .collection("Admin")
              .doc(idadmin.id)
              .update({"iddoc": idadmin.id});
        } else {
          print("ANDA ABSEN MASUK LEBIH AWAL");
          var absen = await firestore
              .collection("Pengguna")
              .doc(uid)
              .collection("Presensi")
              .doc(datenow)
              .set({
            "nama": nama,
            "nomor": nomor,
            "role": statusjabatananda,
            "nim": nim,
            "email": email,
            "tanggal": now.toIso8601String(),
            "idclient": uid,
            "waktu": datenow,
            "masuk": {
              "date": now.toIso8601String(),
              "latitude": position.latitude,
              "longitude": position.longitude,
              "status": "Lebih Awal"
            }
          });
          var idadmin = await firestore.collection("Admin").add({
            "nama": nama,
            "nomor": nomor,
            "email": email,
            "nim": nim,
            "role": statusjabatananda,
            "tanggal": now.toIso8601String(),
            "idclient": uid,
            "waktu": datenow,
            "masuk": {
              "date": now.toIso8601String(),
              "latitude": position.latitude,
              "longitude": position.longitude,
              "status": "Lebih Awal"
            }
          });

          await firestore
              .collection("Admin")
              .doc(idadmin.id)
              .update({"iddoc": idadmin.id});
        }
      } else {
        print("Masuk Ke Else");
        print(datenow);
        DocumentSnapshot<Map<String, dynamic>> todayDocid = await firestore
            .collection("Pengguna")
            .doc(uid)
            .collection("Presensi")
            .doc(datenow)
            .get();
        print(todayDocid.exists);
        if (todayDocid.exists == true) {
          //tinggal absen keluar // sudah absen masuk dan keluar
          Map<String, dynamic>? dataMapToday = todayDocid.data();
          if (dataMapToday?["keluar"] != null) {
            //sudah absen masuk dan keluar
            Get.snackbar("Informasi", "Sudah Absen Masuk Dan Keluar");
          } else {
            // harus absen keluar
            if (convertnow >= convertnw) {
              print("INI CONVERT NOW ${convertnow}");
              print("INI CONVERT NW ${convertnw}");
              print("Absen Keluar Selesai");
              await firestore
                  .collection("Pengguna")
                  .doc(uid)
                  .collection("Presensi")
                  .doc(datenow)
                  .update({
                "tanggal": now.toIso8601String(),
                "Status": "Hadir",
                "keluar": {
                  "date": now.toIso8601String(),
                  "latitude": position.latitude,
                  "longitude": position.longitude,
                  "status": "Sudah Absen"
                }
              });

              final rekap =
                  await firestore.collection("rekapan").doc(datenow).get();

              if (rekap.data() == null) {
                //
                await firestore.collection("rekapan").doc(datenow).set({
                  "Hadir": 1,
                  "Waktu": datenow,
                  "Sakit": 0,
                  "Izin": 0,
                  "Tidak Hadir": 34,
                  "tanggal": DateTime.now().toIso8601String()
                });
              } else {
                var ambiljmlhadir =
                    await firestore.collection("rekapan").doc(datenow).get();
                print(
                    "INI AMBIL JUMLAH KEHADIRAN:${ambiljmlhadir.data()?["Hadir"]}");
                await firestore.collection("rekapan").doc(datenow).update({
                  "Hadir": ambiljmlhadir.data()!["Hadir"] + 1,
                  "Tidak Hadir": ambiljmlhadir.data()!["Tidak Hadir"] - 1
                });
              }

              print("INI REKAP : ${rekap.data()}");

              var get = await firestore
                  .collection("Admin")
                  .where("idclient", isEqualTo: uid)
                  .where("waktu", isEqualTo: datenow)
                  .get();
              print("ADA NGGAK ${get.docs.length}");
              var bukaan = get.docs[0].data();
              if (get.docs.length == 1) {
                print("Satu");
                await firestore
                    .collection("Admin")
                    .doc(bukaan["iddoc"])
                    .update({
                  "tanggal": now.toIso8601String(),
                  "keluar": {
                    "date": now.toIso8601String(),
                    "latitude": position.latitude,
                    "longitude": position.longitude,
                    "status": "Sudah Absen"
                  }
                });
              }
            } else {
              print("Absen Keluar Lebih Awal");
              await firestore
                  .collection("Pengguna")
                  .doc(uid)
                  .collection("Presensi")
                  .doc(datenow)
                  .update({
                "Status": "Hadir",
                "tanggal": now.toIso8601String(),
                "keluar": {
                  "date": now.toIso8601String(),
                  "latitude": position.latitude,
                  "longitude": position.longitude,
                  "status": "Lebih Awal"
                }
              });
              final rekap =
                  await firestore.collection("rekapan").doc(datenow).get();

              if (rekap.data() == null) {
                //
                await firestore.collection("rekapan").doc(datenow).set({
                  "Hadir": 1,
                  "Waktu": datenow,
                  "Sakit": 0,
                  "Izin": 0,
                  "Tidak Hadir": 34,
                  "tanggal": DateTime.now().toIso8601String()
                });
              } else {
                var ambiljmlhadir =
                    await firestore.collection("rekapan").doc(datenow).get();
                print(
                    "INI AMBIL JUMLAH KEHADIRAN:${ambiljmlhadir.data()?["Hadir"]}");
                await firestore.collection("rekapan").doc(datenow).update({
                  "Hadir": ambiljmlhadir.data()!["Hadir"] + 1,
                  "Tidak Hadir": ambiljmlhadir.data()!["Tidak Hadir"] - 1
                });
              }
              print("INI REKAP : ${rekap.data()}");
              var get = await firestore
                  .collection("Admin")
                  .where("idclient", isEqualTo: uid)
                  .where("waktu", isEqualTo: datenow)
                  .get();
              print("ADA NGGAK ${get.docs.length}");
              var bukaan = get.docs[0].data();
              if (get.docs.length == 1) {
                print("Satu");
                await firestore
                    .collection("Admin")
                    .doc(bukaan["iddoc"])
                    .update({
                  "tanggal": now.toIso8601String(),
                  "keluar": {
                    "date": now.toIso8601String(),
                    "latitude": position.latitude,
                    "longitude": position.longitude,
                    "status": "Lebih Awal"
                  }
                });
              }
            }
          }
        } else {
          // absen masuk
          if (convertnow >= convert) {
            print("Anda Terlambat");
            var absen = await firestore
                .collection("Pengguna")
                .doc(uid)
                .collection("Presensi")
                .doc(datenow)
                .set({
              "tanggal": now.toIso8601String(),
              "nama": nama,
              "role": statusjabatananda,
              "nomor": nomor,
              "nim": nim,
              "email": email,
              "idclient": uid,
              "waktu": datenow,
              "masuk": {
                "date": now.toIso8601String(),
                "latitude": position.latitude,
                "longitude": position.longitude,
                "status": "Terlambat Masuk"
              }
            });
            var idadmin = await firestore.collection("Admin").add({
              "tanggal": now.toIso8601String(),
              "idclient": uid,
              "nomor": nomor,
              "waktu": datenow,
              "nim": nim,
              "role": statusjabatananda,
              "nama": nama,
              "email": email,
              "masuk": {
                "date": now.toIso8601String(),
                "latitude": position.latitude,
                "longitude": position.longitude,
                "status": "Terlambat Masuk"
              }
            });

            await firestore
                .collection("Admin")
                .doc(idadmin.id)
                .update({"iddoc": idadmin.id});
          } else {
            print("ANDA ABSEN MASUK LEBIH AWAL");
            var absen = await firestore
                .collection("Pengguna")
                .doc(uid)
                .collection("Presensi")
                .doc(datenow)
                .set({
              "tanggal": now.toIso8601String(),
              "idclient": uid,
              "role": statusjabatananda,
              "nim": nim,
              "nomor": nomor,
              "waktu": datenow,
              "nama": nama,
              "email": email,
              "masuk": {
                "date": now.toIso8601String(),
                "latitude": position.latitude,
                "longitude": position.longitude,
                "status": "Lebih Awal"
              }
            });
            var idadmin = await firestore.collection("Admin").add({
              "tanggal": now.toIso8601String(),
              "idclient": uid,
              "waktu": datenow,
              "nomor": nomor,
              "role": statusjabatananda,
              "nim": nim,
              "nama": nama,
              "email": email,
              "masuk": {
                "date": now.toIso8601String(),
                "latitude": position.latitude,
                "longitude": position.longitude,
                "status": "Lebih Awal"
              }
            });

            await firestore
                .collection("Admin")
                .doc(idadmin.id)
                .update({"iddoc": idadmin.id});
          }
        }
      }
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // return Future.error('Location services are disabled.');
      return {
        "error": true,
        "message":
            "Izin Lokasi Anda Sedang Nonaktif, Silahkan Aktifkan Lokasi Anda"
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // return Future.error('Location permissions are denied');
        return {
          "error": true,
          "message": "Izin Lokasi Anda Ditolak, Silahkan Izinkan Lokasi Anda"
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
      return {
        "error": true,
        "message":
            "Izin Lokasi Anda Ditolak Permanen, Silahkan Izinkan Lokasi Anda"
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    return {
      "error": false,
      "position": position,
      "message": "Berhasil Mendapatkan Lokasi Device"
    };
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getLastPresence() async* {
    String uid = auth.currentUser!.uid;
    yield* await firestore
        .collection("Pengguna")
        .doc(uid)
        .collection("Presensi")
        .orderBy("tanggal", descending: true)
        .limit(2)
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> dataUser() async {
    String uid = auth.currentUser!.uid;

    return firestore.collection("Pengguna").doc(uid).get();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> today() async* {
    String uid = auth.currentUser!.uid;
    String datenow =
        DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");

    yield* firestore
        .collection("Pengguna")
        .doc(uid)
        .collection("Presensi")
        .doc(datenow)
        .snapshots();
  }

  // void test() async {
  //   Stream<DocumentSnapshot<Map<String, dynamic>>> datastream =
  //       await firestore.collection("Pengaturan").doc("1").snapshots();
  //   print(datastream);
  // }
}
