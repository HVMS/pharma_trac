import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharma_trac/UserProfile/edit_profile_screen.dart';
import 'package:pharma_trac/Utils/colors_utils.dart';
import 'package:pharma_trac/Utils/string_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';

class UserProfileScreen extends StatelessWidget{

  const UserProfileScreen({super.key});

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
                Divider(
                  height: 20.0,
                  thickness: 2.0,
                  color: ColorUtils.grey,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('images/man.png'),
                      backgroundColor: Colors.transparent,
                      radius: 75,
                    ),
                    Column(
                      children: [
                        Text(
                          StringUtils.userFullName,
                          style: GoogleFonts.kiwiMaru(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: ColorUtils.black,
                          ),
                        ),
                        Text(
                          StringUtils.userEmailAddress,
                          style: GoogleFonts.kiwiMaru(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: ColorUtils.black,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen()));
                      },
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('images/edit_icon.png'),
                        backgroundColor: Colors.transparent,
                        radius: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Divider(
                  height: 20.0,
                  thickness: 2.0,
                  color: ColorUtils.grey,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset('Icons/password_icon.svg'),
                      const SizedBox(width: 20),
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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset('Icons/rating_icon.svg'),
                      const SizedBox(width: 20),
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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset('Icons/logout_icon.svg'),
                      const SizedBox(width: 20),
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


