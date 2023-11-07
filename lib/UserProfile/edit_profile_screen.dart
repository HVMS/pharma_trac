import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma_trac/Utils/string_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_trac/customWidgets/CustomEditProfileRow.dart';
import '../Utils/colors_utils.dart';
import '../customWidgets/CustomGreyDivider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreen();
}

class _EditProfileScreen extends State<EditProfileScreen>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringUtils.editScreenAppBarTitle,
          style: GoogleFonts.roboto(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: ColorUtils.white,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              CustomEditProfileRow(title: StringUtils.name, value: StringUtils.userFullName),
              SizedBox(height: 5),
              CustomGreyDivider(),
              CustomEditProfileRow(title: StringUtils.emailAddress, value: StringUtils.userFullName),
              SizedBox(height: 5),
              CustomGreyDivider(),
              CustomEditProfileRow(title: StringUtils.countryName, value: StringUtils.userFullName),
              SizedBox(height: 5),
              CustomGreyDivider(),
              CustomEditProfileRow(title: StringUtils.height, value: StringUtils.userFullName),
              SizedBox(height: 5),
              CustomGreyDivider(),
              CustomEditProfileRow(title: StringUtils.weight, value: StringUtils.userFullName),
            ],
          ),
        ),
      ),
    );
  }
}
