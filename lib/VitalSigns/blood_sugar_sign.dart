import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:pharma_trac/Utils/string_utils.dart';
import 'package:pharma_trac/model/VitalSign/blood_sugar_model.dart';

import '../Utils/colors_utils.dart';
import '../Utils/extra_utils.dart';
import '../Utils/styleUtils.dart';
import '../customWidgets/VitalSigns/custom_bottomsheet_bar_vital_sign.dart';
import '../services/vital_signs_api.dart';

class BloodSugarSign extends StatefulWidget {
  const BloodSugarSign({super.key});

  @override
  State<BloodSugarSign> createState() => _BloodSugarSignState();
}

class _BloodSugarSignState extends State<BloodSugarSign> {

  late Box userDataBox;
  String userId = '';
  String bloodSugarValue = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDataBox = Hive.box('userData');
    userId = userDataBox.get("_id", defaultValue: '');
    getBloodSugarDataInitially();
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
                  vitalSignText: StringUtils.bloodSugarText,
                  buttonColor: ColorUtils.blueColorCardView,
                  vitalSignMeasurementText: StringUtils.bloodSugarMeasurement,
                );
              });
        },
        child: Card(
          color: ColorUtils.blueColorCardView,
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset('Icons/blood_sugar.svg'),
                  Text(
                    StringUtils.bloodSugarText,
                    style: StyleUtils.robotoTextStyle(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bloodSugarValue,
                    style: StyleUtils.robotoTextStyle(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringUtils.bloodSugarMeasurement,
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

  void getBloodSugarDataInitially() async {
    print(userId);

    BloodSugarModel bloodPressureModelResponse = await VitalSignsService.getBloodSugar(userId);

    if (bloodPressureModelResponse.statusCode == 200) {
      List<BloodSugarModelResponse?>? responseData =
          bloodPressureModelResponse.response;

      // Check if responseData is null
      if (responseData != null) {
        // Get current time
        DateTime now = DateTime.now();

        // Filter the response data
        List<BloodSugarModelResponse?> filteredDataNullable =
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
            bloodSugarValue = "--";
          });
        } else if (filteredDataNullable != null) {
          List<dynamic> filteredData = filteredDataNullable
              .whereType<BloodSugarModelResponse>()
              .toList();

          ExtraUtils.sortData(filteredData);
          setState(() {
            bloodSugarValue = filteredData[0].bloodSugar!;
          });
        }
      }
    } else {
      setState(() {
        bloodSugarValue = "--";
      });
    }
  }

}
