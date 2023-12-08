import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:pharma_trac/VitalSigns/blood_cholesterol.dart';
import 'package:pharma_trac/model/VitalSign/blood_cholesterol_model.dart';
import 'package:pharma_trac/model/VitalSign/body_temperature_model.dart';
import 'package:pharma_trac/model/VitalSign/heart_rate_model.dart';

import '../model/VitalSign/blood_pressure_model.dart';
import '../model/VitalSign/blood_sugar_model.dart';
import '../services/vital_signs_api.dart';

class YearPickerGraph extends StatefulWidget {
  final String vitalSignTitle;
  const YearPickerGraph({super.key, required this.vitalSignTitle});

  @override
  State<YearPickerGraph> createState() => _YearPickerGraphState();
}

class _YearPickerGraphState extends State<YearPickerGraph> {
  int selectedYear = DateTime.now().year;
  late Box userDataBox;
  String userId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDataBox = Hive.box('userData');
    userId = userDataBox.get("_id", defaultValue: '');
    callVitalSignDataYearWise(selectedYear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  selectPreviousYear();
                  print(selectedYear);
                  callVitalSignDataYearWise(selectedYear);
                },
              ),
              Text(
                'Year $selectedYear',
                style: const TextStyle(fontSize: 20.0),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: selectedYear < DateTime.now().year
                    ? () {
                        selectNextYear();
                        print(selectedYear);
                        callVitalSignDataYearWise(selectedYear);
                      }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void callVitalSignDataYearWise(int selectedYear){
    if (widget.vitalSignTitle == 'Blood Pressure'){
      getBloodPressureDataByYear(selectedYear);
    } else if (widget.vitalSignTitle == 'Blood Sugar'){
      getBloodSugarDataByYear(selectedYear);
    } else if (widget.vitalSignTitle == 'Temperature'){
      getBodyTemperatureDataByYear(selectedYear);
    } else if (widget.vitalSignTitle == 'Blood Cholesterol'){
      getBloodCholesterolDataByYear(selectedYear);
    } else {
      getHeartRateDataByYear(selectedYear);
    }
  }

  void selectNextYear() {
    setState(() {
      selectedYear++;
    });
  }

  void selectPreviousYear() {
    setState(() {
      selectedYear--;
    });
  }

  void getHeartRateDataByYear(int selectedYear) async {
    print(userId);

    HeartRateModel heartRateModelResponse = await VitalSignsService.getHeartRate(userId);

    if (heartRateModelResponse.statusCode == 200) {
      List<HeartRateModelResponse?>? responseData =
          heartRateModelResponse.response;

      DateFormat dateFormat = DateFormat("MMMM d, yyyy");

      // Check if responseData is null
      if (responseData != null) {
        List<dynamic> filteredData = responseData
            .whereType<HeartRateModelResponse>()
            .where(
                (element) => dateFormat.parse(element.date!).year == selectedYear)
            .toList();

        double sumOfHeartRate = 0.0;

        if (filteredData == null || filteredData.isEmpty){
          print("No data available");
        } else {
          filteredData.forEach((element) {
            sumOfHeartRate += double.parse(element.heartRate);
          });

          double averageOfHeartRate = sumOfHeartRate / filteredData.length;

          print("Average heart rate : ${averageOfHeartRate.toStringAsFixed(2)}");
        }
      }
    } else {
      print("Response is null!!");
    }
  }

  void getBloodCholesterolDataByYear(int selectedYear) async {
    print(userId);

    BloodCholesterolModel bloodCholesterolModelResponse = await VitalSignsService.getBloodCholesterol(userId);

    if (bloodCholesterolModelResponse.statusCode == 200) {
      List<BloodCholesterolModelResponse?>? responseData =
          bloodCholesterolModelResponse.response;

      DateFormat dateFormat = DateFormat("MMMM d, yyyy");

      // Check if responseData is null
      if (responseData != null) {
        List<dynamic> filteredData = responseData
            .whereType<BloodCholesterolModelResponse>()
            .where(
                (element) => dateFormat.parse(element.date!).year == selectedYear)
            .toList();

        double sumOfBloodCholesterol = 0.0;

        if (filteredData == null || filteredData.isEmpty){
          print("No data available");
        } else {
          filteredData.forEach((element) {
            sumOfBloodCholesterol += double.parse(element.bloodCholesterol);
          });

          double averageOfBloodCholesterol = sumOfBloodCholesterol / filteredData.length;

          print("Average blood cholesterol: ${averageOfBloodCholesterol.toStringAsFixed(2)}");
        }
      }
    } else {
      print("Response is null!!");
    }
  }

  void getBodyTemperatureDataByYear(int selectedYear) async {
    print(userId);

    BodyTemperatureModel bodyTemperatureModelResponse = await VitalSignsService.getBodyTemperature(userId);

    if (bodyTemperatureModelResponse.statusCode == 200) {
      List<BodyTemperatureModelResponse?>? responseData =
          bodyTemperatureModelResponse.response;

      DateFormat dateFormat = DateFormat("MMMM d, yyyy");

      // Check if responseData is null
      if (responseData != null) {
        List<dynamic> filteredData = responseData
            .whereType<BodyTemperatureModelResponse>()
            .where(
                (element) => dateFormat.parse(element.date!).year == selectedYear)
            .toList();

        double sumOfBodyTemperature = 0.0;

        if (filteredData == null || filteredData.isEmpty){
          print("No data available");
        } else {
          filteredData.forEach((element) {
            sumOfBodyTemperature += double.parse(element.temperature);
          });

          double averageOfBodyTemperature = sumOfBodyTemperature / filteredData.length;

          print("Average body temperature: ${averageOfBodyTemperature.toStringAsFixed(2)}");
        }
      }
    } else {
      print("Response is null!!");
    }
  }

  void getBloodSugarDataByYear(int selectedYear) async {
    print(userId);

    BloodSugarModel bloodSugarModelResponse = await VitalSignsService.getBloodSugar(userId);

    if (bloodSugarModelResponse.statusCode == 200) {
      List<BloodSugarModelResponse?>? responseData =
          bloodSugarModelResponse.response;

      DateFormat dateFormat = DateFormat("MMMM d, yyyy");

      // Check if responseData is null
      if (responseData != null) {
        List<dynamic> filteredData = responseData
            .whereType<BloodSugarModelResponse>()
            .where(
                (element) => dateFormat.parse(element.date!).year == selectedYear)
            .toList();

        double sumOfBloodSugar = 0.0;

        if (filteredData == null || filteredData.isEmpty){
          print("No data available");
        } else {
          filteredData.forEach((element) {
            sumOfBloodSugar += double.parse(element.bloodSugar);
          });

          double averageOfBloodSugar = sumOfBloodSugar / filteredData.length;

          print("Average blood sugar: ${averageOfBloodSugar.toStringAsFixed(2)}");
        }
      }
    } else {
      print("Response is null!!");
    }
  }

  void getBloodPressureDataByYear(int selectedYear) async {
    print(userId);

    BloodPressureModel bloodPressureModelResponse =
        await VitalSignsService.getBloodPressureData(userId);

    if (bloodPressureModelResponse.statusCode == 200) {
      List<BloodPressureModelResponse?>? responseData =
          bloodPressureModelResponse.response;

      DateFormat dateFormat = DateFormat("MMMM d, yyyy");

      // Check if responseData is null
      if (responseData != null) {
        List<dynamic> filteredData = responseData
            .whereType<BloodPressureModelResponse>()
            .where(
                (element) => dateFormat.parse(element.date!).year == selectedYear)
            .toList();

        double sumBeforeSlash = 0.0;
        double sumAfterSlash = 0.0;

        if (filteredData == null || filteredData.isEmpty){
          print("No data available");
        } else {
          filteredData.forEach((element) {
            List<String> values = element.bloodPressure!.split('/');
            sumBeforeSlash += double.parse(values[0]);
            sumAfterSlash += double.parse(values[1]);
          });

          double averageBeforeSlash = sumBeforeSlash / filteredData.length;
          double averageAfterSlash = sumAfterSlash / filteredData.length;

          print("Average blood pressure: ${averageBeforeSlash.toStringAsFixed(2)}/${averageAfterSlash.toStringAsFixed(2)}");
        }
      }
    } else {
      print("Response is null!!");
    }
  }
}