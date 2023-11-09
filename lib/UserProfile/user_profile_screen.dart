import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pharma_trac/UserProfile/edit_profile_screen.dart';
import 'package:pharma_trac/Utils/colors_utils.dart';
import 'package:pharma_trac/Utils/string_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';

import '../customWidgets/CustomGreyDivider.dart';

class UserProfileScreen extends StatefulWidget{

  const UserProfileScreen({super.key});

  @override
  State<StatefulWidget> createState()=> _UserProfileScreen();

}

class _UserProfileScreen extends State<UserProfileScreen>{

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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(StringUtils.userProfileAppBarTitle),
        ),
        body: Container(
          color: ColorUtils.appBackgroundColor,
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15),
              Text(
                StringUtils.editProfileTitle,
                style: GoogleFonts.kiwiMaru(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  color: ColorUtils.black,
                ),
              ),
              const SizedBox(height: 20),
              const CustomGreyDivider(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // SizedBox(
                  //   height: 100,
                  //   width: 100,
                  //   child: IconButton(
                  //     icon: SvgPicture.asset('Icons/user_profile1.svg'),
                  //     color: ColorUtils.signUpButtonColor,
                  //     onPressed: () {  },
                  //   ),
                  // ),
                  CircleAvatar(
                    backgroundColor: ColorUtils.grey,
                    radius: 50,
                    child: SvgPicture.asset('Icons/user_profile1.svg'),
                  ),
                  Column(
                    children: [
                      Text(
                        userDataBox.get('fullName', defaultValue: ''),
                        style: GoogleFonts.kiwiMaru(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: ColorUtils.black,
                        ),
                      ),
                      Text(
                        userDataBox.get('email_address', defaultValue: ''),
                        style: GoogleFonts.kiwiMaru(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: ColorUtils.black,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: SvgPicture.asset('Icons/edit_icon.svg'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const EditProfileScreen()));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const CustomGreyDivider(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: SvgPicture.asset('Icons/password_icon.svg'),
                      onPressed: () {},
                    ),
                    Text(
                      StringUtils.userChangePassword,
                      style: GoogleFonts.kiwiMaru(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        color: ColorUtils.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: SvgPicture.asset('Icons/rating_icon.svg'),
                      onPressed: () {},
                    ),
                    Text(
                      StringUtils.userRatings,
                      style: GoogleFonts.kiwiMaru(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        color: ColorUtils.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: SvgPicture.asset('Icons/logout_icon.svg'),
                      onPressed: () {},
                    ),
                    Text(
                      StringUtils.userLogout,
                      style: GoogleFonts.kiwiMaru(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        color: ColorUtils.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


