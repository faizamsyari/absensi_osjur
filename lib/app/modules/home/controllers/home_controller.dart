import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart ' as pw;

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool loadingabsen = false.obs;
  void logout() async {
    await auth.signOut();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> rekapData() async* {
    yield* firestore.collection("rekapan").snapshots();
  }

  void downloadPdf() async {
    //
    final pdf = pw.Document();
    // ambil database
    var data = await firestore
        .collection("Admin")
        .orderBy("tanggal", descending: true)
        .get();
    //
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return [
          pw.Center(
              child: pw.Text("DATA ABSENSI OSJUR ANGKATAN 2022",
                  style: pw.TextStyle(
                      color: PdfColor.fromHex("#000000"),
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 20))),
          pw.SizedBox(height: 20),
          pw.Table(
              defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
              border: pw.TableBorder.all(color: PdfColor.fromHex("#000000")),
              tableWidth: TableWidth.max,
              children: [
                pw.TableRow(children: [
                  pw.Center(
                    child: pw.Padding(
                      padding: pw.EdgeInsets.all(3),
                      child: pw.Text("NO",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 8, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  pw.Center(
                    child: pw.Padding(
                      padding: pw.EdgeInsets.all(3),
                      child: pw.Text("NAMA",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 8, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  pw.Center(
                    child: pw.Padding(
                      padding: pw.EdgeInsets.all(3),
                      child: pw.Text("KELOMPOK",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 8, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  pw.Center(
                    child: pw.Padding(
                      padding: pw.EdgeInsets.all(3),
                      child: pw.Text("NIM",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 8, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  pw.Center(
                    child: pw.Padding(
                      padding: pw.EdgeInsets.all(3),
                      child: pw.Text("STATUS",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 8, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  pw.Center(
                    child: pw.Padding(
                      padding: pw.EdgeInsets.all(3),
                      child: pw.Text("MASUK",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 8, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  pw.Center(
                    child: pw.Padding(
                      padding: pw.EdgeInsets.all(3),
                      child: pw.Text("KELUAR",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 8, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  pw.Center(
                    child: pw.Padding(
                      padding: pw.EdgeInsets.all(3),
                      child: pw.Text("STATUS MASUK",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 8, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  pw.Center(
                    child: pw.Padding(
                      padding: pw.EdgeInsets.all(3),
                      child: pw.Text("STATUS KELUAR",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 8, fontWeight: FontWeight.bold)),
                    ),
                  )
                ]),
                // INI LIST GENERATE
                ...List.generate(data.docs.length, (index) {
                  return pw.TableRow(children: [
                    pw.Center(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(3),
                        child: pw.Text("${index + 1}",
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    pw.Center(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(3),
                        child: pw.Text("${data.docs[index].data()["nama"]}",
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    pw.Center(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(3),
                        child: pw.Text("${data.docs[index].data()["nomor"]}",
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    pw.Center(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(3),
                        child: pw.Text("${data.docs[index].data()["nim"]}",
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    pw.Center(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(3),
                        child: pw.Text(
                            data.docs[index].data()["role"] == "client"
                                ? "Peserta"
                                : "Panitia",
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    pw.Center(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(3),
                        child: pw.Text(
                            data.docs[index].data()["masuk"] == null
                                ? "Belum Presensi"
                                : "${DateFormat.yMMMEd().format(DateTime.parse(data.docs[index].data()["masuk"]["date"]))}, ${DateFormat.jms().format(DateTime.parse(data.docs[index].data()["masuk"]["date"]))}",
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    pw.Center(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(3),
                        child: pw.Text(
                            data.docs[index].data()["keluar"] == null
                                ? "Belum Presensi"
                                : "${DateFormat.yMMMEd().format(DateTime.parse(data.docs[index].data()["keluar"]["date"]))}, ${DateFormat.jms().format(DateTime.parse(data.docs[index].data()["keluar"]["date"]))}",
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    pw.Center(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(3),
                        child: pw.Text(
                            "${data.docs[index].data()["masuk"]["status"]}",
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    pw.Center(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(3),
                        child: pw.Text(
                            data.docs[index].data()["keluar"] == null
                                ? "Belum Presensi"
                                : data.docs[index].data()["keluar"]["status"],
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    )
                  ]);
                })
              ])
        ];
      },
    ));

    // simpan
    Uint8List bytes = await pdf.save();

    // buat file kosong di direktori
    final dir = await getApplicationDocumentsDirectory();

    final file = File("${dir.path}/absensiosjur.pdf");

    await file.writeAsBytes(bytes);

    // open pdf
    await OpenFile.open(file.path);
  }

  /// Untuk Spreadsheet
  final credentials = r'''
  {
    "type": "service_account",
    "project_id": "absensiosjur",
    "private_key_id": "821869ec3a03bfdfee8bc858a7f6220a4ea315bf",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCSAWCKJRZ9ggLp\ne6FXn0TGnU2/gDLsqTraAav2aO7GNEX8etcl/wAd/6A7s3QFShgKYZKpderuYiT2\nG8i2SGVqx2/biDZvU/gtCKHhwnLKHt/+gJpJujkjk9syUQMrHeCQmiMHUwpdBm+U\n2pcvAMpbMPbSPQ+4+YvCYzbwsYtfg7ymDoAI0k78yv+jY2A053L+fOvYsUFl/Efi\njm0KF0JWGfapWg0g4gc+rw4JM8iYLOtq8HbWpumenZQMoOg0L/IvZvmuatvs4oTN\n5DkmFyZ1HDur4NvoqZwZ9xK2Gq81fXEFWRFFeCLYKo1jG11waF9djPX6hYjIR47N\nEV8fCDcBAgMBAAECggEAAiFrrjhiU/cyDFmAfjiAbBbe4TzWrBDAH27yJR4Hi0mM\np+WG/t1HZtNUcZU/IStL9ILTUrkPcju+Zv+lddDSogns/kVw6JOkxct1c/I+yJJG\nGdRN7BDVRUlNY+Dowe1QBJbV4gUlMTxRzoNDZ4KEcWuNKSjjnNhktgkf7nKOIm5S\nYK2li72fBLE0GLodZi83aigsrFvGt112dHqJOo+B2six28/bgsTFlTI8UU+aLz69\ngSJ19nhH158YFRGUpz1CBv/ATHIPVFagC8u3n2iH/g1Shoa5QfGODrNCxuSEkTTZ\nN6+CGcdzWPPS8k2MwxIjhgVtRHOD7kq3yCFbcY3BUQKBgQDMfr4Al73icr/GMrt7\nwmOBNnXQKfYOglu/2RrBQ5xiCcTMI4cZgO98WCXYSDiFt5mU0yswUjhi75/hJjhz\nr1ONweUroVTwfcSgAVuDRDS7+/aHZfnZMWMp43zbNZE10u2bTFIhZ+XFk2UzO4ZS\nTPUrNbWtkmSl55InXCuoqFYJZQKBgQC2x2LRsnDAgn06LCj5VhCWqsf6nTYMTdoL\nIYvXYf0hLe/Ov4rbXXwhQtkciLLxGC+OqaA4FKaoQpgOZ/h1A2mST/EsUHKC1ucu\nqF6/7oOL9OnxtB+j3VZUKc+SNSXy/VpzhC/zW5hPD/2BNAfdYD3z9OdyBTsbUpIM\npVPB/4VrbQKBgG4L9qvS/PiTz+gU/RfIsEukxxnSuvtr43wGlYNToyCPKTzCEb4D\nyN0dgqA1nVU4TInuaduDI5z6XwuGyfJXc5thsLYeB9uzktCYamrllYtkOHL8ycu7\n7CVqqpI87XwNmphsJfacNuZwP5Gmgs5fY8BxEufpVAiD6f8MduI4VLSRAoGAaAh4\nsI52Krya9l9oOvLHolo2VOjieIJfVvKTG9aEMzxoQC85o75EBtJ7rQgJgbyYZQUb\nUpA+g4rT7W80NbXpgwPJa8WmR95121KuC2SAr0qJVa+GSsiSeHkL0lY58WJO920H\nteYufOHHEqFA0LoUySReD8H2cIjA5D29vK/piskCgYAVX+d1zXpmKdaus3gPJRES\nKWHdsJ7DKhp6iKKUlSM73xCAgL6FXryMil03Oj2E7/fZ3LLuuJ7+QNw+/tCPIRfC\nIO/VSgXeKSqlGqvPQviBJR1LY92/y37Svd3caa33aLldmrlQXUlVilGFaCBYO+2A\nUftzXerpFBed2hrfm/qL3Q==\n-----END PRIVATE KEY-----\n",
    "client_email": "excelexport@absensiosjur.iam.gserviceaccount.com",
    "client_id": "111966240028734842668",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/excelexport%40absensiosjur.iam.gserviceaccount.com"
  }
  ''';

  final spreadsheetid = "1ELSB0hCMAZcKi0BRPxa5cMrdIceBGGtY9xyBT8TcJN0";

  Future<void> downloadexcel() async {
    print("PROSES DOWNLOAD EXCEL");

    loadingabsen.value = true;

    //get data firestore
    var data = await firestore
        .collection("Admin")
        .orderBy("tanggal", descending: true)
        .get();

    final gsheets = GSheets(credentials);
    final ss = await gsheets.spreadsheet(spreadsheetid);
    var sheet = ss.worksheetByTitle("Data");
    await sheet!.clear();
    await sheet.values.insertRows(1, [
      [
        "No",
        "Nama Lengkap",
        "Nomor Kelompok",
        "NIM",
        "Status / Jabatan",
        "Absen Masuk",
        "Absen Keluar",
        "Status Absen Masuk",
        "Status Absen Keluar"
      ]
    ]);
    for (var i = 0; i < data.docs.length; i++) {
      print("INI $i");
      Map<String, dynamic> dataku = data.docs[i].data();
      await sheet.values.appendRows([
        [
          "${i + 1}",
          dataku["nama"],
          dataku["nomor"],
          dataku["nim"],
          dataku["role"] == "client" ? "Peserta" : "Panitia",
          dataku["masuk"] == null
              ? "Belum Presensi "
              : "${DateFormat.yMMMEd().format(DateTime.parse(data.docs[i].data()["masuk"]["date"]))}, ${DateFormat.jms().format(DateTime.parse(data.docs[i].data()["masuk"]["date"]))}",
          dataku["keluar"] == null
              ? "Belum Presensi"
              : "${DateFormat.yMMMEd().format(DateTime.parse(data.docs[i].data()["keluar"]["date"]))}, ${DateFormat.jms().format(DateTime.parse(data.docs[i].data()["keluar"]["date"]))}",
          dataku["masuk"]["status"],
          dataku["keluar"] == null
              ? "Belum Presensi"
              : dataku["keluar"]["status"]
        ]
      ]);
    }

    // List.generate(
    //   data.docs.length,
    //   (index) async {
    //     Map<String, dynamic> dataku = data.docs[index].data();
    //     await sheet!.values.insertRows(, [
    //       [
    //         "${index + 1}",
    //         dataku["nama"],
    //         dataku["nomor"],
    //         dataku["role"] == "client" ? "Peserta" : "Panitia",
    //         "${DateFormat.yMMMEd().format(DateTime.parse(data.docs[index].data()["masuk"]["date"]))}, ${DateFormat.jms().format(DateTime.parse(data.docs[index].data()["masuk"]["date"]))}",
    //         dataku["keluar"] == null
    //             ? "Belum Presensi"
    //             : "${DateFormat.yMMMEd().format(DateTime.parse(data.docs[index].data()["keluar"]["date"]))}, ${DateFormat.jms().format(DateTime.parse(data.docs[index].data()["keluar"]["date"]))}",
    //         dataku["masuk"]["status"],
    //         dataku["keluar"] == null
    //             ? "Belum Presensi"
    //             : dataku["keluar"]["status"]
    //       ]
    //     ]);
    //   },
    // );
    print("Fungsi Test Selesai");
    Get.snackbar("Selamat",
        "Data Berhasil Disimpan Di Google Spreadsheet, Segera Buka Spreadsheet Anda Untuk Melihat Data");
    loadingabsen.value = false;
  }
}
