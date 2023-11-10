import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../Utils/colors_utils.dart';
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
          TimeUtils.greetingMessage() + userDataBox.get("fullName", defaultValue: ''),
          style: GoogleFonts.roboto(
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
            color: ColorUtils.white,
          ),
        ),
      ),
      body: Container(
        color: ColorUtils.appBackgroundColor,
        width: double.maxFinite,
        height: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            color: ColorUtils.white,
          ),
        ),
      ),
    );
  }
}
