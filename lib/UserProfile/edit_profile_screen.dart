import 'package:flutter/material.dart';
import 'package:pharma_trac/Utils/string_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_trac/customWidgets/CustomEditProfileRow.dart';
import 'package:pharma_trac/model/UserInformation.dart';
import '../Utils/colors_utils.dart';
import '../customWidgets/CustomGreyDivider.dart';

class EditProfileScreen extends StatefulWidget {

  final UserInformationUser userInformation;

  const EditProfileScreen({required this.userInformation, super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              CustomEditProfileRow(title: StringUtils.name, value: "${widget.userInformation.fullName}"),
              const SizedBox(height: 5),
              const CustomGreyDivider(),
              CustomEditProfileRow(title: StringUtils.countryName, value: "${widget.userInformation.country}"),
              const SizedBox(height: 5),
              const CustomGreyDivider(),
              CustomEditProfileRow(title: StringUtils.height, value: "${widget.userInformation.height}"),
              const SizedBox(height: 5),
              const CustomGreyDivider(),
              CustomEditProfileRow(title: StringUtils.weight, value: "${widget.userInformation.weight}"),
            ],
          ),
        ),
      ),
    );
  }
}
