import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Utils/colors_utils.dart';

class BloodCholesterol extends StatefulWidget {
  const BloodCholesterol({super.key});

  @override
  State<BloodCholesterol> createState() => _BloodCholesterolState();
}

class _BloodCholesterolState extends State<BloodCholesterol> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        color: ColorUtils.greenColorCardView,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset('Icons/blood_cholesterol.svg'),
                Text(
                  'Blood Cholesterol',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  textDirection: TextDirection.ltr,
                  style: GoogleFonts.roboto(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: ColorUtils.black,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '20',
                  style: GoogleFonts.roboto(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: ColorUtils.black,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'mg per dl',
                  style: GoogleFonts.roboto(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: ColorUtils.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    ;
  }
}
