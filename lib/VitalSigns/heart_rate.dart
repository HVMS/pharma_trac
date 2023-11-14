import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Utils/colors_utils.dart';
import '../Utils/string_utils.dart';
import '../Utils/styleUtils.dart';
import '../customWidgets/VitalSigns/custom_bottomsheet_bar_vital_sign.dart';

class HeartRateSign extends StatefulWidget {
  const HeartRateSign({super.key});

  @override
  State<HeartRateSign> createState() => _HeartRateSignState();
}

class _HeartRateSignState extends State<HeartRateSign> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: (){
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
                      '370',
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
}
