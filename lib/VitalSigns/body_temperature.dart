import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Utils/colors_utils.dart';
import '../Utils/string_utils.dart';
import '../Utils/styleUtils.dart';
import '../customWidgets/VitalSigns/custom_bottomsheet_bar_vital_sign.dart';

class BodyTemperature extends StatefulWidget {
  const BodyTemperature({super.key});

  @override
  State<BodyTemperature> createState() => _BodyTemperatureState();
}

class _BodyTemperatureState extends State<BodyTemperature> {
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
                    '108',
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
}
