import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/colors_utils.dart';
import '../Utils/styleUtils.dart';

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
      child: Container(
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
    );
  }
}
