import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:pharma_trac/VitalSigns/blood_cholesterol.dart';
import 'package:pharma_trac/VitalSigns/blood_pessure_sign.dart';
import 'package:pharma_trac/VitalSigns/blood_sugar_sign.dart';
import 'package:pharma_trac/VitalSigns/body_temperature.dart';
import 'package:pharma_trac/VitalSigns/heart_rate.dart';

import '../Utils/colors_utils.dart';
import '../Utils/styleUtils.dart';
import '../Utils/timeUtils.dart';

class VitalSigns extends StatefulWidget {
  const VitalSigns({super.key});

  @override
  State<VitalSigns> createState() => _VitalSignsState();
}

class _VitalSignsState extends State<VitalSigns> {
  late Box userDataBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDataBox = Hive.box('userData');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          TimeUtils.greetingMessage() +
              userDataBox.get("fullName", defaultValue: ''),
          style: StyleUtils.appBarTextStyle(),
        ),
      ),
      body: Container(
        color: ColorUtils.appBackgroundColor,
        width: double.maxFinite,
        height: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Card(
              color: ColorUtils.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GridView.count(
                    crossAxisCount: 2, // Two cards in each row
                    padding: const EdgeInsets.all(10.0),
                    childAspectRatio: 1.2, // Adjust as needed for your design
                    shrinkWrap: true,
                    children: const <Widget>[
                      BloodPressureSign(),
                      BloodSugarSign(),
                      BodyTemperature(),
                      BloodCholesterol(),
                    ],
                  ),
                  const HeartRateSign(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
