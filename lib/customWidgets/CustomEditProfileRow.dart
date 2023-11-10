import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_trac/customWidgets/editProfileBottomSheetBar.dart';

import '../Utils/colors_utils.dart';

class CustomEditProfileRow extends StatelessWidget {
  final String title;
  final String value;

  const CustomEditProfileRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.kiwiMaru(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  color: ColorUtils.black,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.kiwiMaru(
                  fontSize: 15.0,
                  color: ColorUtils.black,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: SvgPicture.asset('Icons/arrow_forward.svg'),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return EditProfileBottomSheetBar(titleValue: title, responseValue: value);
                },
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                );
          },
        ),
      ],
    );
  }
}