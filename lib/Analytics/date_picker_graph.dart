import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../Utils/styleUtils.dart';
import '../model/VitalSign/blood_cholesterol_model.dart';
import '../model/VitalSign/blood_pressure_model.dart';
import '../model/VitalSign/blood_sugar_model.dart';
import '../model/VitalSign/body_temperature_model.dart';
import '../model/VitalSign/heart_rate_model.dart';
import '../services/vital_signs_api.dart';
import 'date_wise_graph.dart';
import 'date_wise_single_bar_graph.dart';

class DatePickerGraph extends StatefulWidget {
  final String vitalSignTitle;
  const DatePickerGraph({Key? key, required this.vitalSignTitle})
      : super(key: key);

  @override
  State<DatePickerGraph> createState() => _DatePickerGraphState();
}

class _DatePickerGraphState extends State<DatePickerGraph> {
  DateTime currentDate = DateTime.now();
  late Box userDataBox;
  String userId = '';

  final List<BloodPressureData> dataBloodPressure = [];

  final List<VitalSignData> vitalSignData = [];

  @override
  void initState() {
    // TODO: implement initState
    userDataBox = Hive.box('userData');
    userId = userDataBox.get("_id", defaultValue: '');
    callAPIVitalSignDateWise(currentDate);
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
                    selectPreviousDate();
                    print(currentDate);
                    callAPIVitalSignDateWise(currentDate);
                  },
                ),
                Text(
                  formattedDate(currentDate),
                  style: const TextStyle(fontSize: 20.0),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: currentDate.isBefore(
                          DateTime.now().subtract(const Duration(days: 1)))
                      ? () {
                          selectNextDate();
                          print(currentDate);
                          callAPIVitalSignDateWise(currentDate);
                        }
                      : null,
                ),
              ],
            ),
            if (widget.vitalSignTitle == 'Blood Pressure')
              FutureBuilder(
                future: callAPIVitalSignDateWise(currentDate),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Expanded(
                      child: dataBloodPressure != null && dataBloodPressure.isNotEmpty
                          ? DateTimeCategoryLabel(
                              data: dataBloodPressure,
                              vitalSignText: widget.vitalSignTitle)
                          : Center(
                              child: Text('No Data Available!!',
                                  style: StyleUtils.robotoLightTextStyle()),
                            ),
                    );
                  }
                },
              )
            else
              FutureBuilder(
                future: callAPIVitalSignDateWise(currentDate),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Expanded(
                      child: vitalSignData != null && vitalSignData.isNotEmpty
                          ? DateWiseSingleBarGraph(
                              data: vitalSignData,
                              vitalSignText: widget.vitalSignTitle)
                          : Center(
                              child: Text('No Data Available!!',
                                  style: StyleUtils.robotoLightTextStyle()),
                            ),
                    );
                  }
                },
              )
          ],
        ),
      ),
    );
  }

  String formattedDate(DateTime date) {
    return DateFormat('MMMM dd, yyyy').format(date);
  }

  void selectNextDate() {
    setState(() {
      currentDate = currentDate.add(const Duration(days: 1));
    });
  }

  void selectPreviousDate() {
    setState(() {
      currentDate = currentDate.subtract(const Duration(days: 1));
    });
  }

  Future<void> callAPIVitalSignDateWise(DateTime currentDate) async {
    if (widget.vitalSignTitle == 'Blood Pressure') {
      List<BloodPressureModelResponse> data = await getBloodPressureDataByDate(currentDate);
      dataBloodPressure.clear();
      for (int i = 0; i < data.length; i++) {
        print(data[i].bloodPressure);
        double systolicValue =
            double.parse(data[i].bloodPressure!.split('/')[0]);
        double dialosticValue =
            double.parse(data[i].bloodPressure!.split('/')[1]);

        DateFormat dateTimeFormat = DateFormat("MMMM dd, yyyy h:mm a");
        DateTime dateTime =
            dateTimeFormat.parse("${data[i].date!} ${data[i].time!}");

        dataBloodPressure.add(BloodPressureData(
            DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour,
                dateTime.minute),
            BloodPressure(systolicValue, dialosticValue)));
      }

    } else if (widget.vitalSignTitle == 'Blood Sugar') {

      List data = await getBloodSugarDataByDate(currentDate);
      vitalSignData.clear();

      for (int i = 0; i < data.length; i++) {
        print(data[i].bloodSugar);
        double bloodSugarValue = double.parse(data[i].bloodSugar!);

        DateFormat dateTimeFormat = DateFormat("MMMM dd, yyyy h:mm a");
        DateTime dateTime = dateTimeFormat.parse("${data[i].date!} ${data[i].time!}");

        vitalSignData.add(VitalSignData(dateTime, bloodSugarValue));
      }

    } else if (widget.vitalSignTitle == 'Temperature') {

      List data = await getBodyTemperatureDataByDate(currentDate);

      vitalSignData.clear();

      for (int i = 0; i < data.length; i++) {
        print(data[i].temperature);
        double temperatureValue = double.parse(data[i].temperature!);

        DateFormat dateTimeFormat = DateFormat("MMMM dd, yyyy h:mm a");
        DateTime dateTime = dateTimeFormat.parse("${data[i].date!} ${data[i].time!}");

        vitalSignData.add(VitalSignData(dateTime, temperatureValue));
      }

    } else if (widget.vitalSignTitle == 'Blood Cholesterol') {
      List data = await getBloodCholesterolDataByDate(currentDate);

      vitalSignData.clear();

      for (int i = 0; i < data.length; i++) {
        print(data[i].bloodCholesterol);
        double bloodCholesterolValue = double.parse(data[i].bloodCholesterol!);

        DateFormat dateTimeFormat = DateFormat("MMMM dd, yyyy h:mm a");
        DateTime dateTime = dateTimeFormat.parse("${data[i].date!} ${data[i].time!}");

        vitalSignData.add(VitalSignData(dateTime, bloodCholesterolValue));
      }
    } else {
      List data = await getHeartRateDataByDate(currentDate);

      vitalSignData.clear();

      for (int i = 0; i < data.length; i++) {
        print(data[i].heartRate);
        double heartRateValue = double.parse(data[i].heartRate!);

        DateFormat dateTimeFormat = DateFormat("MMMM dd, yyyy h:mm a");
        DateTime dateTime = dateTimeFormat.parse("${data[i].date!} ${data[i].time!}");

        vitalSignData.add(VitalSignData(dateTime, heartRateValue));
      }
    }
  }

  Future<List> getHeartRateDataByDate(DateTime currentDate) async {
    print(userId);

    HeartRateModel heartRateModelResponse = await VitalSignsService.getHeartRate(userId);

    try {
      if (heartRateModelResponse.statusCode == 200) {
        List<HeartRateModelResponse?>? responseData =
            heartRateModelResponse.response;

        DateFormat dateFormat = DateFormat("MMMM d, yyyy");

        // Check if responseData is null
        if (responseData != null) {
          List<HeartRateModelResponse> filteredData = responseData
              .whereType<HeartRateModelResponse>()
              .where((element) {
                DateTime elementDate = dateFormat.parse(element.date!);
                DateTime elementDateYMD = DateTime(elementDate.year, elementDate.month, elementDate.day);
                DateTime currentDateYMD = DateTime(currentDate.year, currentDate.month, currentDate.day);

                return elementDateYMD == currentDateYMD;
              }).toList();

          if (filteredData == null || filteredData.isEmpty) {
            print("No data available");
          } else {
            return filteredData;
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

  Future<List> getBloodCholesterolDataByDate(DateTime currentDate) async {
    print(userId);

    BloodCholesterolModel bloodCholesterolModelResponse = await VitalSignsService.getBloodCholesterol(userId);

    try {
      if (bloodCholesterolModelResponse.statusCode == 200) {
        List<BloodCholesterolModelResponse?>? responseData =
            bloodCholesterolModelResponse.response;

        DateFormat dateFormat = DateFormat("MMMM d, yyyy");

        // Check if responseData is null
        if (responseData != null) {
          List<BloodCholesterolModelResponse> filteredData = responseData
              .whereType<BloodCholesterolModelResponse>()
              .where((element) {
                DateTime elementDate = dateFormat.parse(element.date!);
                DateTime elementDateYMD = DateTime(elementDate.year, elementDate.month, elementDate.day);
                DateTime currentDateYMD = DateTime(currentDate.year, currentDate.month, currentDate.day);

                return elementDateYMD == currentDateYMD;
              }).toList();

          if (filteredData == null || filteredData.isEmpty) {
            print("No data available");
          } else {
            return filteredData;
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

  Future<List> getBodyTemperatureDataByDate(DateTime currentDate) async {
    print(userId);

    BodyTemperatureModel bodyTemperatureModelResponse = await VitalSignsService.getBodyTemperature(userId);

    try {
      if (bodyTemperatureModelResponse.statusCode == 200) {
        List<BodyTemperatureModelResponse?>? responseData =
            bodyTemperatureModelResponse.response;

        DateFormat dateFormat = DateFormat("MMMM d, yyyy");

        // Check if responseData is null
        if (responseData != null) {
          List<BodyTemperatureModelResponse> filteredData = responseData
              .whereType<BodyTemperatureModelResponse>()
              .where((element) {
                DateTime elementDate = dateFormat.parse(element.date!);
                DateTime elementDateYMD = DateTime(elementDate.year, elementDate.month, elementDate.day);
                DateTime currentDateYMD = DateTime(currentDate.year, currentDate.month, currentDate.day);

                return elementDateYMD == currentDateYMD;
              }).toList();

          if (filteredData == null || filteredData.isEmpty) {
            print("No data available");
          } else {
            return filteredData;
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

  Future<List> getBloodSugarDataByDate(DateTime currentDate) async {
    print(userId);

    BloodSugarModel bloodSugarModelResponse = await VitalSignsService.getBloodSugar(userId);

    try {
      if (bloodSugarModelResponse.statusCode == 200) {
        List<BloodSugarModelResponse?>? responseData =
            bloodSugarModelResponse.response;

        DateFormat dateFormat = DateFormat("MMMM d, yyyy");

        // Check if responseData is null
        if (responseData != null) {
          List<BloodSugarModelResponse> filteredData = responseData
              .whereType<BloodSugarModelResponse>()
              .where((element) {
                DateTime elementDate = dateFormat.parse(element.date!);
                DateTime elementDateYMD = DateTime(elementDate.year, elementDate.month, elementDate.day);
                DateTime currentDateYMD = DateTime(currentDate.year, currentDate.month, currentDate.day);

                return elementDateYMD == currentDateYMD;
              }).toList();

          if (filteredData == null || filteredData.isEmpty) {
            print("No data available");
          } else {
            return filteredData;
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

  Future<List<BloodPressureModelResponse>> getBloodPressureDataByDate(DateTime currentDate) async {
    print(userId);

    BloodPressureModel bloodPressureModelResponse = await VitalSignsService.getBloodPressureData(userId);

    try {
      if (bloodPressureModelResponse.statusCode == 200) {
        List<BloodPressureModelResponse?>? responseData =
            bloodPressureModelResponse.response;

        DateFormat dateFormat = DateFormat("MMMM dd, yyyy");

        // Check if responseData is null
        if (responseData != null) {
          List<BloodPressureModelResponse> filteredData = responseData
              .whereType<BloodPressureModelResponse>()
              .where((element) {
            DateTime elementDate = dateFormat.parse(element.date!);
            DateTime elementDateYMD =
                DateTime(elementDate.year, elementDate.month, elementDate.day);
            DateTime currentDateYMD =
                DateTime(currentDate.year, currentDate.month, currentDate.day);

            return elementDateYMD == currentDateYMD;
          }).toList();

          if (filteredData == null || filteredData.isEmpty) {
            print("No data available");
          } else {
            return filteredData;
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
