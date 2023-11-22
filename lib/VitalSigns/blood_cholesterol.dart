import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:pharma_trac/model/VitalSign/blood_cholesterol_model.dart';
import '../Utils/colors_utils.dart';
import '../Utils/extra_utils.dart';
import '../Utils/string_utils.dart';
import '../Utils/styleUtils.dart';
import '../customWidgets/VitalSigns/custom_bottomsheet_bar_vital_sign.dart';
import '../services/vital_signs_api.dart';

class BloodCholesterol extends StatefulWidget {
  const BloodCholesterol({super.key});

  @override
  State<BloodCholesterol> createState() => _BloodCholesterolState();
}

class _BloodCholesterolState extends State<BloodCholesterol> {

  late Box userDataBox;
  String userId = '';
  String bloodCholesterolValue = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDataBox = Hive.box('userData');
    userId = userDataBox.get("_id", defaultValue: '');
    getBloodCholesterolDataInitially();
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
                  vitalSignText: StringUtils.bloodCholesterolText,
                  buttonColor: ColorUtils.greenColorCardView,
                  vitalSignMeasurementText: StringUtils.bloodCholesterolMeasurement,
                );
              });
        },
        child: Card(
          color: ColorUtils.greenColorCardView,
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset('Icons/blood_cholesterol.svg'),
                  Text(
                    StringUtils.bloodCholesterolText,
                    style: StyleUtils.robotoTextStyle(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bloodCholesterolValue,
                    style: StyleUtils.robotoTextStyle(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringUtils.bloodCholesterolMeasurement,
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

  void getBloodCholesterolDataInitially() async {
    print(userId);

    BloodCholesterolModel bloodPressureModelResponse =
    await VitalSignsService.getBloodCholesterol(userId);

    if (bloodPressureModelResponse.statusCode == 200) {
      List<BloodCholesterolModelResponse?>? responseData =
          bloodPressureModelResponse.response;

      // Check if responseData is null
      if (responseData != null) {
        // Get current time
        DateTime now = DateTime.now();

        // Filter the response data
        List<BloodCholesterolModelResponse?> filteredDataNullable = responseData.where((entry) {
          if (entry != null) {
            DateFormat format = DateFormat("MMMM d, yyyy h:mm a");
            DateTime entryDateTime = format.parse("${entry.date} ${entry.time}");
            return entryDateTime.isBefore(now);
          } else {
            return false;
          }
        }).toList();

        if (filteredDataNullable.isEmpty) {
          setState(() {
            bloodCholesterolValue = "--";
          });
        } else {
          List<dynamic> filteredData = filteredDataNullable
              .whereType<BloodCholesterolModelResponse>()
              .toList();

          ExtraUtils.sortData(filteredData);
          setState(() {
            bloodCholesterolValue = filteredData[0].bloodCholesterol!;
          });
        }
      }
    } else {
      setState(() {
        bloodCholesterolValue = "--";
      });
    }
  }
}
