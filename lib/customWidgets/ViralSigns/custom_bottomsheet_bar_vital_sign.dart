import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_trac/Utils/styleUtils.dart';

import '../../Utils/colors_utils.dart';
import '../../Utils/string_utils.dart';
import '../CustomGreyDivider.dart';

class CustomBottomSheetBarVitalSigns extends StatefulWidget {
  const CustomBottomSheetBarVitalSigns({super.key});

  @override
  State<CustomBottomSheetBarVitalSigns> createState() => _CustomBottomSheetBarVitalSignsState();
}

class _CustomBottomSheetBarVitalSignsState extends State<CustomBottomSheetBarVitalSigns> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.0,
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("Update your data",
                        style: StyleUtils.bottomSheetTitleStyle(),
                      ),
                    ),
                  ),
                ],
              ),
              const CustomGreyDivider(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                StringUtils.timeText,
                style: StyleUtils.bottomSheetTextStyle(),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Text(
                  StringUtils.timeText,
                  style: StyleUtils.bottomSheetTextStyle(),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Text(
                  StringUtils.timeText,
                  style: StyleUtils.bottomSheetTextStyle(),
                ),
              ),
            ],
          ),
          const CustomGreyDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  StringUtils.bottomSheetBarBloodSugarText,
                  style: StyleUtils.bottomSheetTextStyle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  StringUtils.bottomSheetBarBloodSugarMeasurementText,
                  style: StyleUtils.bottomSheetTextStyle(),
                ),
              ),
            ],
          ),
          const CustomGreyDivider(),
          Column(
            children: [
              const CustomGreyDivider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 60),
                    elevation: 2.0,
                    backgroundColor: ColorUtils.registerButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    StringUtils.update,
                    style: GoogleFonts.kiwiMaru(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: ColorUtils.emailAddressTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
