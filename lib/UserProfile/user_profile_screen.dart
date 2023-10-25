import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: <Widget>[
                Text(
                  StringUtils.editProfileTitle,
                  style: GoogleFonts.kiwiMaru(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    color: ColorUtils.black,
                  ),
                ),
                Divider(
                  height: 20.0,
                  thickness: 2.0,
                  color: ColorUtils.grey,
                ),
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
                    const CircleAvatar(
                      backgroundImage: AssetImage('images/edit_icon.png'),
                      backgroundColor: Colors.transparent,
                      radius: 15,
                    ),
                  ],
                ),
                Divider(
                  height: 20.0,
                  thickness: 2.0,
                  color: ColorUtils.grey,
                ),
              ],
            ),
          ),
        ),
    );
  }

}


