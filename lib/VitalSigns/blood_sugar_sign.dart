import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma_trac/Utils/string_utils.dart';

import '../Utils/colors_utils.dart';
import '../Utils/styleUtils.dart';

class BloodSugarSign extends StatefulWidget {
  const BloodSugarSign({super.key});

  @override
  State<BloodSugarSign> createState() => _BloodSugarSignState();
}

class _BloodSugarSignState extends State<BloodSugarSign> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
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
                  '15',
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
    );
  }
}
