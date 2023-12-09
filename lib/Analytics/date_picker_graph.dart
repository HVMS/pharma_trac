import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../Utils/styleUtils.dart';
import '../model/VitalSign/blood_pressure_model.dart';
import '../services/vital_signs_api.dart';
import 'date_wise_graph.dart';

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
            FutureBuilder(
              future: callAPIVitalSignDateWise(currentDate),
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
                    child: dataBloodPressure != null &&
                            dataBloodPressure.isNotEmpty
                        ? DateTimeCategoryLabel(
                            data: dataBloodPressure,
                            vitalSignText: widget.vitalSignTitle)
                        : Center(
                            child: Text('No Data Available!!',
                                style: StyleUtils.robotoLightTextStyle()),
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
      List<BloodPressureModelResponse> data =
          await getBloodPressureDataDateWise(currentDate);
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
      print(dataBloodPressure);
    }
  }

  Future<List<BloodPressureModelResponse>> getBloodPressureDataDateWise(
      DateTime currentDate) async {
    print(userId);

    BloodPressureModel bloodPressureModelResponse =
        await VitalSignsService.getBloodPressureData(userId);

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
            DateFormat timeFormat = DateFormat("h:mm a");

            DateTime currentDate = DateTime.now();

            DateTime currentTime =
                timeFormat.parse(DateFormat('h:mm a').format(currentDate));
            DateTime elementTime = timeFormat.parse(element.time!);

            DateTime elementDate = dateFormat.parse(element.date!);
            DateTime elementDateYMD =
                DateTime(elementDate.year, elementDate.month, elementDate.day);
            DateTime currentDateYMD =
                DateTime(currentDate.year, currentDate.month, currentDate.day);

            return elementDateYMD == currentDateYMD &&
                elementTime.isBefore(currentTime);
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
