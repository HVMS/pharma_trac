import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
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

class _EditProfileScreen extends State<EditProfileScreen> {

  late Box userDataBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDataBox = Hive.box('userData');
  }

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
              CustomEditProfileRow(title: StringUtils.name, value: userDataBox.get('fullName', defaultValue: '')),
              const SizedBox(height: 5),
              const CustomGreyDivider(),
              CustomEditProfileRow(title: StringUtils.countryName, value: userDataBox.get('country', defaultValue: '')),
              const SizedBox(height: 5),
              const CustomGreyDivider(),
              CustomEditProfileRow(title: StringUtils.height, value: userDataBox.get('height', defaultValue: '')),
              const SizedBox(height: 5),
              const CustomGreyDivider(),
              CustomEditProfileRow(title: StringUtils.weight, value: userDataBox.get('weight', defaultValue: '')),
            ],
          ),
        ),
      ),
    );
  }
}
