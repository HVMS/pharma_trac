import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pharma_trac/Utils/string_utils.dart';
import 'package:pharma_trac/customWidgets/CustomEditProfileRow.dart';
import '../Utils/styleUtils.dart';
import '../customWidgets/CustomGreyDivider.dart';
import '../model/User/UserInformation.dart';
import '../services/users_api.dart';

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
    userDataBox = Hive.box('userDataBox');

    // String dateString = "November 15, 2023";
    // DateFormat dateFormat = DateFormat("MMMM d, yyyy");
    // DateTime dateTime = dateFormat.parse(dateString);
    // print("date time object is here ==>");
    // print(dateTime);
    //
    // print(DateFormat("EEEE").format(dateTime));

  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringUtils.editScreenAppBarTitle,
          style: StyleUtils.appBarTextStyle(),
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
