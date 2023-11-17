import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:pharma_trac/Utils/styleUtils.dart';
import 'package:pharma_trac/model/VitalSign/blood_pressure_model.dart';
import 'package:pharma_trac/services/vital_signs_api.dart';
import '../Utils/colors_utils.dart';
import '../Utils/string_utils.dart';
import '../customWidgets/VitalSigns/custom_bottomsheet_bar_blood_pressure.dart';

class BloodPressureSign extends StatefulWidget {
  const BloodPressureSign({super.key});

  @override
  State<BloodPressureSign> createState() => _BloodPressureSignState();
}

class _BloodPressureSignState extends State<BloodPressureSign> {
  late Box userDataBox;
  String userId = '';
  String bloodPressureValue = '';

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
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useRootNavigator: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              builder: (context) {
                return BloodPressureCustomBottomSheetBar(
                  vitalSignText: StringUtils.bloodPressureText,
                  buttonColor: ColorUtils.redColorCardView,
                  vitalSignMeasurementText:
                      StringUtils.bloodPressureMeasurement,
                );
              });
        },
        child: Card(
          color: ColorUtils.redColorCardView,
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset('Icons/blood-pressure.svg'),
                  Text(
                    StringUtils.bloodPressureText,
                    style: StyleUtils.robotoTextStyle(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bloodPressureValue,
                    style: StyleUtils.robotoTextStyle(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringUtils.bloodPressureMeasurement,
                    style: StyleUtils.robotoTextStyle(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
        // Get current time
        DateTime now = DateTime.now();

        // Filter the response data
        List<BloodPressureModelResponse?> filteredDataNullable =
            responseData.where((entry) {
          // Check if entry is null
          if (entry != null) {
            DateFormat format = DateFormat("MMMM d, yyyy h:mm a");
            DateTime entryDateTime =
                format.parse("${entry.date} ${entry.time}");
            return entryDateTime.isBefore(now);
          } else {
            return false;
          }
        }).toList();

        if (filteredDataNullable.isEmpty) {
          setState(() {
            bloodPressureValue = "--/--";
          });
        } else if (filteredDataNullable != null) {
          List<BloodPressureModelResponse> filteredData = filteredDataNullable
              .whereType<BloodPressureModelResponse>()
              .toList();

          filteredData.sort((a, b) {
            DateFormat format = DateFormat("MMMM d, yyyy h:mm a");
            DateTime aDateTime = format.parse("${a.date} ${a.time}");
            DateTime bDateTime = format.parse("${b.date} ${b.time}");
            return bDateTime.compareTo(aDateTime);
          });

          print(filteredData);

          setState(() {
            bloodPressureValue = filteredData[0].bloodPressure!;
          });

        }
      }
    } else {
      setState(() {
        bloodPressureValue = "--/--";
      });
    }
  }
}
