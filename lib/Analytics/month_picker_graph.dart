import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:pharma_trac/Analytics/year_wise_graph.dart';

import '../Utils/styleUtils.dart';
import '../model/VitalSign/blood_cholesterol_model.dart';
import '../model/VitalSign/blood_pressure_model.dart';
import '../model/VitalSign/blood_sugar_model.dart';
import '../model/VitalSign/body_temperature_model.dart';
import '../model/VitalSign/heart_rate_model.dart';
import '../services/vital_signs_api.dart';

class MonthPickerGraph extends StatefulWidget {
  final String vitalSignTitle;
  const MonthPickerGraph({super.key, required this.vitalSignTitle});

  @override
  State<MonthPickerGraph> createState() => _MonthPickerGraphState();
}

class _MonthPickerGraphState extends State<MonthPickerGraph> {
  DateTime currentDate = DateTime.now();
  late Box userDataBox;
  String userId = '';

  final List<ChartData> chartData = [];
  final MaterialColor blueColor = Colors.blue;
  final MaterialColor redColor = Colors.red;
  final MaterialColor greenColor = Colors.green;
  final MaterialAccentColor orangeColor = Colors.deepOrangeAccent;

  @override
  void initState() {
    // TODO: implement initState
    userDataBox = Hive.box('userData');
    userId = userDataBox.get("_id", defaultValue: '');

    callVitalSignDataMonthWise(currentDate);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    selectPreviousMonth();
                    callVitalSignDataMonthWise(currentDate);
                  },
                ),
                Text(
                  formattedDate(currentDate),
                  style: const TextStyle(fontSize: 20.0),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: canSelectNextMonth()
                      ? () {
                          selectNextMonth();
                          callVitalSignDataMonthWise(currentDate);
                        }
                      : null,
                ),
              ],
            ),

            FutureBuilder(
              future: callVitalSignDataMonthWise(currentDate),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading spinner while waiting for data
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text(
                    // Show error message if something went wrong
                      'Error: ${snapshot.error}');
                } else {
                  return Expanded(
                    child: chartData != null && chartData.isNotEmpty
                        ? YearWiseGraph(data: chartData, vitalSignText: widget.vitalSignTitle)
                        : Center(
                      child: Text('No Data Available!!', style: StyleUtils.robotoLightTextStyle()),
                    ), // Return an empty container if chartData is null or empty
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> callVitalSignDataMonthWise(DateTime currentDate) async {
    if (widget.vitalSignTitle == 'Blood Pressure') {
      List<String> value = await getBloodPressureDataByYear(currentDate);
      if (value.isNotEmpty){
        double systolicValue = double.parse(value[0]);
        print(systolicValue);
        double diastolicValue = double.parse(value[1]);
        print(diastolicValue);
        chartData.clear();
        chartData.add(ChartData('systolic\nValue', systolicValue, blueColor));
        chartData.add(ChartData('Lowest\nsystolic', 120.0, greenColor));
        chartData.add(ChartData('Highest\nsystolic', 180.0, redColor));
        chartData.add(ChartData('diastolic\nValue', diastolicValue, blueColor));
        chartData.add(ChartData('Lowest\ndiastolic', 80.0, greenColor));
        chartData.add(ChartData('Highest\ndiastolic', 120.0, redColor));
      } else {
        chartData.clear();
      }
    } else if (widget.vitalSignTitle == 'Blood Sugar') {
      double value = await getBloodSugarDataByYear(currentDate);
      if (value > 0.0) {
        chartData.clear();
        chartData.add(ChartData('Your\nBlood\nSugar', value, blueColor));
        chartData.add(ChartData('Normal\nlimit', 100.0, greenColor));
        chartData.add(ChartData('Pre\nDiabetes\nlimit', 125.0, redColor));
        chartData.add(ChartData('Diabetes\nlimit', 140.0, orangeColor));
      } else {
        chartData.clear();
      }
    } else if (widget.vitalSignTitle == 'Temperature') {
      double value = await getBodyTemperatureDataByYear(currentDate);
      if (value > 0.0) {
        chartData.clear();
        chartData.add(ChartData('Your\nTemperature', value, blueColor));
        chartData.add(ChartData('Normal\nlimit', 98.6, greenColor));
        chartData.add(ChartData('High\nlimit', 99.1, redColor));
      } else {
        chartData.clear();
      }
    } else if (widget.vitalSignTitle == 'Blood Cholesterol') {
      double value = await getBloodCholesterolDataByYear(currentDate);
      if (value > 0.0) {
        chartData.clear();
        chartData.add(ChartData('Your\nBlood\nCholesterol', value, blueColor));
        chartData.add(ChartData('Normal\nlimit', 220.0, greenColor));
        chartData.add(ChartData('High\nlimit', 250.0, redColor));
      } else {
        chartData.clear();
      }
    } else {
      double value = await getHeartRateDataByYear(currentDate);
      if (value > 0.0) {
        chartData.clear();
        chartData.add(ChartData('Your\nHeart\nRate', value, blueColor));
        chartData.add(ChartData('Normal\nlimit', 80.0, greenColor));
        chartData.add(ChartData('High\nlimit', 110.0, redColor));
      } else {
        chartData.clear();
      }
    }
  }

  bool canSelectNextMonth() {
    // Disable the forward icon if the selected month is the current month
    DateTime nextMonth = DateTime.now().add(const Duration(days: 1)).subtract(const Duration(days: 1));
    return currentDate.isBefore(nextMonth) && currentDate.month != nextMonth.month;
  }


  String formattedDate(DateTime date) {
    return "${DateFormat.MMMM().format(date)} ${date.year}";
  }

  void selectNextMonth() {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month + 1);
    });
  }

  void selectPreviousMonth() {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month - 1);
    });
  }

  Future<double> getHeartRateDataByYear(DateTime currentDate) async {
    print(userId);

    HeartRateModel heartRateModelResponse =
    await VitalSignsService.getHeartRate(userId);

    double averageOfHeartRate = 0.0;

    try {
      if (heartRateModelResponse.statusCode == 200) {
        List<HeartRateModelResponse?>? responseData =
            heartRateModelResponse.response;

        DateFormat dateFormat = DateFormat("MMMM d, yyyy");

        // Check if responseData is null
        if (responseData != null) {
          List<dynamic> filteredData = responseData
              .whereType<HeartRateModelResponse>()
              .where((element) {
                DateTime elementDate = dateFormat.parse(element.date!);
                return elementDate.month == currentDate.month;
              }).toList();

          print(filteredData);

          double sumOfHeartRate = 0.0;

          for (var element in filteredData) {
            print(element.heartRate);
            sumOfHeartRate += double.parse(element.heartRate);
          }

          averageOfHeartRate = averageOfHeartRate + sumOfHeartRate / filteredData.length;

          print("Average heart rate : $averageOfHeartRate");

          return averageOfHeartRate;
        }
      } else {
        print("Response is null!!");
      }

      return averageOfHeartRate;

    } on Exception catch (e) {
      // TODO
      print(e);
      rethrow;
    }
  }

  Future<double> getBloodCholesterolDataByYear(DateTime currentDate) async {
    print(userId);

    BloodCholesterolModel bloodCholesterolModelResponse =
    await VitalSignsService.getBloodCholesterol(userId);

    double averageOfBloodCholesterol = 0.0;

    try {
      if (bloodCholesterolModelResponse.statusCode == 200) {
        List<BloodCholesterolModelResponse?>? responseData =
            bloodCholesterolModelResponse.response;

        DateFormat dateFormat = DateFormat("MMMM d, yyyy");

        // Check if responseData is null
        if (responseData != null) {
          List<dynamic> filteredData = responseData
              .whereType<BloodCholesterolModelResponse>()
              .where((element) {
                DateTime elementDate = dateFormat.parse(element.date!);
                return elementDate.month == currentDate.month;
              }).toList();

          double sumOfBloodCholesterol = 0.0;

          for (var element in filteredData) {
            sumOfBloodCholesterol += double.parse(element.bloodCholesterol);
          }

          averageOfBloodCholesterol += sumOfBloodCholesterol / filteredData.length;
          print("Average blood cholesterol: $averageOfBloodCholesterol");

          return averageOfBloodCholesterol;
        }
      } else {
        print("Response is null!!");
      }
      return averageOfBloodCholesterol;
    } on Exception catch (e) {
      // TODO
      print(e);
      rethrow;
    }
  }

  Future<double> getBodyTemperatureDataByYear(DateTime currentDate) async {
    print(userId);

    BodyTemperatureModel bodyTemperatureModelResponse =
    await VitalSignsService.getBodyTemperature(userId);

    double averageOfBodyTemperature = 0.0;

    try {
      if (bodyTemperatureModelResponse.statusCode == 200) {
        List<BodyTemperatureModelResponse?>? responseData =
            bodyTemperatureModelResponse.response;

        DateFormat dateFormat = DateFormat("MMMM d, yyyy");

        // Check if responseData is null
        if (responseData != null) {
          List<dynamic> filteredData = responseData
              .whereType<BodyTemperatureModelResponse>()
              .where((element) {
                DateTime elementDate = dateFormat.parse(element.date!);
                return elementDate.month == currentDate.month;
              }).toList();

          double sumOfBodyTemperature = 0.0;

          for (var element in filteredData) {
            sumOfBodyTemperature += double.parse(element.temperature);
          }

          averageOfBodyTemperature += sumOfBodyTemperature / filteredData.length;

          print("Average body temperature: $averageOfBodyTemperature");

          return averageOfBodyTemperature;
        }
      } else {
        print("Response is null!!");
      }
      return averageOfBodyTemperature;
    } on Exception catch (e) {
      // TODO
      print(e);
      rethrow;
    }
  }

  Future<double> getBloodSugarDataByYear(DateTime currentDate) async {
    print(userId);

    BloodSugarModel bloodSugarModelResponse =
    await VitalSignsService.getBloodSugar(userId);

    double averageOfBloodSugar = 0.0;
    try {
      if (bloodSugarModelResponse.statusCode == 200) {
        List<BloodSugarModelResponse?>? responseData =
            bloodSugarModelResponse.response;

        DateFormat dateFormat = DateFormat("MMMM d, yyyy");

        // Check if responseData is null
        if (responseData != null) {
          List<dynamic> filteredData = responseData
              .whereType<BloodSugarModelResponse>()
              .where((element) {
                DateTime elementDate = dateFormat.parse(element.date!);
                return elementDate.month == currentDate.month;
              }).toList();

          double sumOfBloodSugar = 0.0;

          for (var element in filteredData) {
            sumOfBloodSugar += double.parse(element.bloodSugar);
          }
          averageOfBloodSugar += sumOfBloodSugar / filteredData.length;
          print("Average blood sugar: $averageOfBloodSugar");

          return averageOfBloodSugar;
        }
      } else {
        print("Response is null!!");
      }
      return averageOfBloodSugar;
    } on Exception catch (e) {
      // TODO
      print(e);
      rethrow;
    }
  }

  Future<List<String>> getBloodPressureDataByYear(DateTime currentDate) async {
    print(userId);

    BloodPressureModel bloodPressureModelResponse =
    await VitalSignsService.getBloodPressureData(userId);

    try {
      if (bloodPressureModelResponse.statusCode == 200) {
        List<BloodPressureModelResponse?>? responseData =
            bloodPressureModelResponse.response;

        DateFormat dateFormat = DateFormat("MMMM d, yyyy");

        // Check if responseData is null
        if (responseData != null) {
          List<dynamic> filteredData = responseData
              .whereType<BloodPressureModelResponse>()
              .where((element) {
                DateTime elementDate = dateFormat.parse(element.date!);
                return elementDate.month == currentDate.month;
              }).toList();

          double sumBeforeSlash = 0.0;
          double sumAfterSlash = 0.0;

          if (filteredData == null || filteredData.isEmpty) {
            print("No data available");
          } else {
            for (var element in filteredData) {
              List<String> values = element.bloodPressure!.split('/');
              sumBeforeSlash += double.parse(values[0]);
              sumAfterSlash += double.parse(values[1]);
            }

            double averageBeforeSlash = sumBeforeSlash / filteredData.length;
            double averageAfterSlash = sumAfterSlash / filteredData.length;

            print(
                "Average blood pressure: ${averageBeforeSlash.toStringAsFixed(2)}/${averageAfterSlash.toStringAsFixed(2)}");

            List<String> dataFinal = [];
            dataFinal.add(averageBeforeSlash.toStringAsFixed(2));
            dataFinal.add(averageAfterSlash.toStringAsFixed(2));

            return dataFinal;
          }
        }
      } else {
        print("Response is null!!");
      }

      return [];
    } on Exception catch (e) {
      // TODO


      print(e);
      rethrow;
    }
  }
}
