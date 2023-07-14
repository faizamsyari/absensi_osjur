import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chart_controller.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartView extends GetView<ChartController> {
  const ChartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    final tinggi = MediaQuery.of(context).size.height;

    final List<SalesData> chartData = [];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Grafik Data"),
        ),
        body: StreamBuilder(
          stream: controller.rekapData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print("LAGI WAITING");
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              print("MASUK KE HAS DATA");
              print(snapshot.data?.docs.length);
              print(snapshot.data?.docs[0].data());
              snapshot.data?.docs.forEach(
                (element) {
                  print(element.data().runtimeType);
                  chartData.add(SalesData(
                      element.data()["Waktu"],
                      element.data()["Izin"],
                      element.data()["Sakit"],
                      element.data()["Tidak Hadir"],
                      element.data()["Hadir"]));
                },
              );
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: tinggi,
                  width: lebar,
                  child: SfCartesianChart(
                      legend: Legend(
                        isVisible: true,
                        shouldAlwaysShowScrollbar: true,
                        position: LegendPosition.bottom,
                      ),
                      primaryXAxis: CategoryAxis(),
                      series: <ChartSeries>[
                        // Renders line chart
                        LineSeries<SalesData, String>(
                            color: Colors.black,
                            name: "Mahasiswa Izin",
                            width: 5,
                            dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                            ),
                            markerSettings: const MarkerSettings(
                                isVisible: true,
                                color: Colors.black,
                                width: 10,
                                height: 10),
                            dataSource: chartData,
                            xValueMapper: (SalesData sales, _) => sales.waktu,
                            yValueMapper: (SalesData sales, _) => sales.izin),
                        LineSeries<SalesData, String>(
                            color: Colors.orange,
                            name: "Mahasiswa Sakit",
                            width: 5,
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                            markerSettings: const MarkerSettings(
                                isVisible: true,
                                color: Colors.purple,
                                width: 10,
                                height: 10),
                            dataSource: chartData,
                            xValueMapper: (SalesData sales, _) => sales.waktu,
                            yValueMapper: (SalesData sales, _) => sales.sakit),
                        LineSeries<SalesData, String>(
                            name: "Mahasiswa Tidak Hadir",
                            color: Colors.green,
                            width: 5,
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                            markerSettings: const MarkerSettings(
                                isVisible: true,
                                color: Colors.yellow,
                                width: 10,
                                height: 10),
                            dataSource: chartData,
                            xValueMapper: (SalesData sales, _) => sales.waktu,
                            yValueMapper: (SalesData sales, _) =>
                                sales.tdkhadir),
                        LineSeries<SalesData, String>(
                            name: "Mahasiswa Hadir",
                            color: Colors.red.shade700,
                            width: 5,
                            dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                            ),
                            markerSettings: const MarkerSettings(
                                isVisible: true,
                                color: Colors.black,
                                width: 10,
                                height: 10),
                            dataSource: chartData,
                            xValueMapper: (SalesData sales, _) => sales.waktu,
                            yValueMapper: (SalesData sales, _) => sales.hadir),
                      ]),
                ),
              );
            } else {
              print("MASUK KE ELSE");
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.waktu, this.izin, this.sakit, this.tdkhadir, this.hadir);
  final String? waktu;
  final int? izin;
  final int? sakit;
  final int? tdkhadir;
  final int? hadir;
}
