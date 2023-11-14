import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharma_trac/Utils/styleUtils.dart';
import '../Utils/colors_utils.dart';
import '../Utils/string_utils.dart';
import '../customWidgets/VitalSigns/custom_bottomsheet_bar_vital_sign.dart';

class BloodPressureSign extends StatefulWidget {
  const BloodPressureSign({super.key});

  @override
  State<BloodPressureSign> createState() => _BloodPressureSignState();
}

class _BloodPressureSignState extends State<BloodPressureSign> {
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
                  vitalSignText: StringUtils.bloodPressureText,
                  buttonColor: ColorUtils.redColorCardView,
                  vitalSignMeasurementText: StringUtils.bloodPressureMeasurement,
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
                    '20 / 40',
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
}
