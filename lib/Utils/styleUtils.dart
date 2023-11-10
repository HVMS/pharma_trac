import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors_utils.dart';


class StyleUtils {

  static TextStyle robotoTextStyle() {
    return GoogleFonts.roboto(
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
      color: ColorUtils.black,
    );
  }

  static TextStyle appBarTextStyle() {
    return GoogleFonts.roboto(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: ColorUtils.white,
    );
  }

  static TextStyle robotoLightTextStyle() {
    return GoogleFonts.roboto(
      fontSize: 15.0,
      fontWeight: FontWeight.w300,
      color: ColorUtils.black,
    );
  }

  static TextStyle bottomSheetTitleStyle() {
    return GoogleFonts.roboto(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: ColorUtils.black,
    );
  }

  static TextStyle bottomSheetTextStyle() {
    return GoogleFonts.roboto(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: ColorUtils.black,
    );
  }

}