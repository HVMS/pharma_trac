import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Utils/colors_utils.dart';
import '../Utils/string_utils.dart';
import '../Utils/styleUtils.dart';

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
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tapping Card!!'),
            ),
          );
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
                    '20',
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
}