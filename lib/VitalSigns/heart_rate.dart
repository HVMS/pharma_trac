import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:pharma_trac/model/VitalSign/heart_rate_model.dart';

import '../Utils/colors_utils.dart';
import '../Utils/extra_utils.dart';
import '../Utils/string_utils.dart';
import '../Utils/styleUtils.dart';
import '../customWidgets/VitalSigns/custom_bottomsheet_bar_vital_sign.dart';
import '../services/vital_signs_api.dart';

class HeartRateSign extends StatefulWidget {
  const HeartRateSign({super.key});

  @override
  State<HeartRateSign> createState() => _HeartRateSignState();
}

class _HeartRateSignState extends State<HeartRateSign> {
  late Box userDataBox;
  String userId = '';

  String heartRateValue = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDataBox = Hive.box('userData');
    userId = userDataBox.get("_id", defaultValue: '');
    getHeartRateDataInitially();
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
                  vitalSignText: StringUtils.bottomSheetBarHeartText,
                  buttonColor: ColorUtils.heartRateColorCardView,
                  vitalSignMeasurementText: StringUtils.bottomSheetBarHeartMeasurementText,
                );
              });
        },
        child: SizedBox(
          height: 150,
          width: 150,
          child: Card(
            color: ColorUtils.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80),
              //set border radius more than 50% of height and width to make circle
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset('Icons/heart_rate_icon.svg'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      heartRateValue,
                      style: StyleUtils.robotoTextStyle(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'BPM',
                      style: StyleUtils.robotoTextStyle(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getHeartRateDataInitially() async {
    print(userId);

    HeartRateModel bloodPressureModelResponse =
        await VitalSignsService.getHeartRate(userId);

    if (bloodPressureModelResponse.statusCode == 200) {
      List<HeartRateModelResponse?>? responseData =
          bloodPressureModelResponse.response;

      // Check if responseData is null
      if (responseData != null) {
        // Get current time
        DateTime now = DateTime.now();

        // Filter the response data
        List<HeartRateModelResponse?> filteredDataNullable =
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
            heartRateValue = "--";
          });
        } else {
          List<dynamic> filteredData = filteredDataNullable
              .whereType<HeartRateModelResponse>()
              .toList();

          ExtraUtils.sortData(filteredData);
          setState(() {
            heartRateValue = filteredData[0].heartRate!;
          });
        }
      }
    } else {
      setState(() {
        heartRateValue = "--";
      });
    }
  }
}
