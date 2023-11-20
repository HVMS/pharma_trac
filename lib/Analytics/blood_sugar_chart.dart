import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../model/VitalSign/blood_sugar_model.dart';
import '../services/vital_signs_api.dart';

class BloodSugarChart extends StatefulWidget {

  const BloodSugarChart({super.key});

  @override
  State<BloodSugarChart> createState() => _BloodSugarChartState();
}

class _BloodSugarChartState extends State<BloodSugarChart> {

  late Box userDataBox;
  String userId = '';
  late List<BloodSugarModelResponse?>? data = [];

  @override
  void initState() {
    // TODO: implement initState
    userDataBox = Hive.box('userData');
    userId = userDataBox.get("_id", defaultValue: '');
    getBloodSugarDataInitial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    DateFormat inputFormat = DateFormat("MMMM d, yyyy");

    List<FlSpot>? spots = data?.map((bs) {
      DateTime parsedDate = inputFormat.parse(bs!.date.toString());
      return FlSpot(
        parsedDate.millisecondsSinceEpoch.toDouble(),
        double.parse(bs.bloodSugar.toString()),
      );
    }).toList();

    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: spots!,
            isCurved: true,
            color: Colors.blue,
            dotData: const FlDotData(show: false),
          ),
        ],
        minY: 0,
        titlesData: const FlTitlesData(show: true),
        borderData: FlBorderData(show: false),
      ),
    );
  }

  Future<void> getBloodSugarDataInitial() async {
    BloodSugarModel bloodPressureModelResponse =
    await VitalSignsService.getBloodSugar(userId);
    if (bloodPressureModelResponse.statusCode == 200) {
      // Now add the data to the list data
      data = bloodPressureModelResponse.response;
      print(data);
    }
  }

}
