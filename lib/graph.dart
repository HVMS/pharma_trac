import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  late List<Map<String, String>> data = [
    {"blood_sugar": "180", "date": "November 16, 2023", "time": "1:11"},
    {"blood_sugar": "140", "date": "November 16, 2023", "time": "2:45"},
    {"blood_sugar": "160", "date": "November 16, 2023", "time": "3:45"},
    {"blood_sugar": "140", "date": "November 16, 2023", "time": "4:03"},
    {"blood_sugar": "180", "date": "November 16, 2023", "time": "5:09"},
    {"blood_sugar": "100", "date": "November 16, 2023", "time": "6:26"},
    {"blood_sugar": "80", "date": "November 16, 2023", "time": "7:49"},
    {"blood_sugar": "0", "date": "November 16, 2023", "time": "8:12"},
    {"blood_sugar": "84", "date": "November 15, 2023", "time": "12:25 PM"},
    {"blood_sugar": "118", "date": "November 15, 2023", "time": "10:19 PM"},
    {"blood_sugar": "124", "date": "November 11, 2023", "time": "2:17 AM"},
    {"blood_sugar": "123", "date": "November 11, 2023", "time": "2:17 PM"},
    {"blood_sugar": "167", "date": "November 13, 2023", "time": "3:27 AM"},
    {"blood_sugar": "89", "date": "November 13, 2023", "time": "6:27 PM"},
    {"blood_sugar": "89", "date": "November 23, 2023", "time": "6:27 PM"}
  ];

  late List<Map<String, String>> filteredData =
      data.where((entry) => entry['date'] == 'November 16, 2023').toList();

  late List<double?> bloodSugarValues =
      filteredData.map((entry) => double.parse(entry['blood_sugar']!)).toList();

  late List<String> timeValues = filteredData.map((e) => e['time']!).toList();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Blood Sugar Chart'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child : SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(
              interval: 20, // Set the interval based on your requirement
            ),
            series: <LineSeries<Map<String, String>, String>>[
              LineSeries<Map<String, String>, String>(
                dataSource: filteredData,
                xValueMapper: (Map<String, String> entry, _) => entry['time']!,
                yValueMapper: (Map<String, String> entry, _) =>
                    double.parse(entry['blood_sugar']!),
                name: 'Blood Sugar',
              ),
            ],
            title: ChartTitle(
              text: 'Blood Sugar Chart',
            ),
          ),
          // child: LineChart(
          //   LineChartData(
          //     backgroundColor: Colors.transparent,
          //     lineBarsData: [
          //       LineChartBarData(
          //         spots: List.generate(
          //             bloodSugarValues.length,
          //             (index) =>
          //                 FlSpot(index.toDouble(), bloodSugarValues[index]!)),
          //         isCurved: true,
          //         color: Colors.blueAccent,
          //         dotData: const FlDotData(show: true),
          //       ),
          //     ],
          //     titlesData: FlTitlesData(
          //         leftTitles: const AxisTitles(
          //           sideTitles: SideTitles(showTitles: false),
          //           axisNameSize: 20.0,
          //           axisNameWidget: Text('Blood Sugar Data'),
          //         ),
          //         show: true,
          //         bottomTitles: AxisTitles(
          //           sideTitles: SideTitles(
          //             showTitles: true,
          //             reservedSize: 24,
          //             interval: 2.0,
          //             getTitlesWidget: (value, titleMeta) {
          //               int index = value.toInt();
          //               if (index >= 0 && index < timeValues.length) {
          //                 return Text(
          //                   timeValues[index],
          //                   style: const TextStyle(
          //                     color: Colors.black,
          //                     fontSize: 12,
          //                   ),
          //                 );
          //               }
          //               return Container(); // Return an empty container for values outside the range
          //             },
          //           ),
          //           axisNameSize: 20.0,
          //           axisNameWidget: const Text('Time'),
          //         )),
          //   ),
          // ),
        ),
      ),
    );
  }
}
