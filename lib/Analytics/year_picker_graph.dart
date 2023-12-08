import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/VitalSign/blood_pressure_model.dart';
import '../services/vital_signs_api.dart';

class YearPickerGraph extends StatefulWidget {
  const YearPickerGraph({super.key});

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
    getBloodPressureDataInitially();
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
                      }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
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

  void getBloodPressureDataInitially() async {
    print(userId);

    BloodPressureModel bloodPressureModelResponse =
        await VitalSignsService.getBloodPressureData(userId);

    if (bloodPressureModelResponse.statusCode == 200) {
      List<BloodPressureModelResponse?>? responseData =
          bloodPressureModelResponse.response;

      // Check if responseData is null
      if (responseData != null) {
        List<dynamic> filteredData =
            responseData.whereType<BloodPressureModelResponse>().toList();

        double sumBeforeSlash = 0.0;
        double sumAfterSlash = 0.0;

        filteredData.forEach((element) {
          List<String> values = element.bloodPressure!.split('/');
          sumBeforeSlash += double.parse(values[0]);
          sumAfterSlash += double.parse(values[1]);
        });

        double averageBeforeSlash = sumBeforeSlash / filteredData.length;
        double averageAfterSlash = sumAfterSlash / filteredData.length;

        print(
            "Average blood pressure: ${averageBeforeSlash.toStringAsFixed(2)}/${averageAfterSlash.toStringAsFixed(2)}");
      }
    } else {
      print("Response is null!!");
    }
  }
}
