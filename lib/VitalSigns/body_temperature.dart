import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:pharma_trac/model/VitalSign/body_temperature_model.dart';

import '../Utils/colors_utils.dart';
import '../Utils/extra_utils.dart';
import '../Utils/string_utils.dart';
import '../Utils/styleUtils.dart';
import '../customWidgets/VitalSigns/custom_bottomsheet_bar_vital_sign.dart';
import '../services/vital_signs_api.dart';

class BodyTemperature extends StatefulWidget {
  const BodyTemperature({super.key});

  @override
  State<BodyTemperature> createState() => _BodyTemperatureState();
}

class _BodyTemperatureState extends State<BodyTemperature> {

  late Box userDataBox;
  String userId = '';
  String bodyTemperatureValue = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDataBox = Hive.box('userData');
    userId = userDataBox.get("_id", defaultValue: '');
    getBodyTemperatureDataInitially();
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
                return CustomBottomSheetBarVitalSigns(
                  vitalSignText: StringUtils.bodyTemperatureText,
                  buttonColor: ColorUtils.yellowColorCardView,
                  vitalSignMeasurementText: StringUtils.bodyTemperatureMeasurement,
                );
              });
        },
        child: Card(
          color: ColorUtils.yellowColorCardView,
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset('Icons/temperature.svg'),
                  Text(
                    StringUtils.bodyTemperatureText,
                    style: StyleUtils.robotoTextStyle(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bodyTemperatureValue,
                    style: StyleUtils.robotoTextStyle(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringUtils.bodyTemperatureMeasurement,
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

  void getBodyTemperatureDataInitially() async {
    print(userId);

    BodyTemperatureModel bloodPressureModelResponse =
    await VitalSignsService.getBodyTemperature(userId);

    if (bloodPressureModelResponse.statusCode == 200) {
      List<BodyTemperatureModelResponse?>? responseData =
          bloodPressureModelResponse.response;

      // Check if responseData is null
      if (responseData != null) {
        // Get current time
        DateTime now = DateTime.now();

        // Filter the response data
        List<BodyTemperatureModelResponse?> filteredDataNullable =
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
            bodyTemperatureValue = "--";
          });
        } else if (filteredDataNullable != null) {
          List<dynamic> filteredData = filteredDataNullable
              .whereType<BodyTemperatureModelResponse>()
              .toList();

          ExtraUtils.sortData(filteredData);
          setState(() {
            bodyTemperatureValue = filteredData[0].temperature!;
          });
        }
      }
    } else {
      setState(() {
        bodyTemperatureValue = "--";
      });
    }
  }
}
