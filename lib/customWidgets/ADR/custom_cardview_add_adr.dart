import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma_trac/Utils/styleUtils.dart';

class CustomAddADRCardView extends StatelessWidget {
  const CustomAddADRCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "ADR By Drug Name",
                  style: StyleUtils.robotoTextStyle(),
                ),
                const SizedBox(height: 10.0),
                SvgPicture.asset('Icons/add_drug_icon.svg'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
