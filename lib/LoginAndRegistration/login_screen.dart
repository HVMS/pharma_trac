import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_trac/LoginAndRegistration/registration_screen.dart';
import 'package:pharma_trac/Utils/string_utils.dart';

import '../Utils/colors_utils.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              ColorUtils.primaryColor,
              ColorUtils.secondaryColor,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('images/Logo1.png'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          StringUtils.emailAddress,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.kiwiMaru(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: ColorUtils.emailAddressTextColor,
                          ),
                        ),
                        TextFormField(
                          cursorColor: ColorUtils.black,
                          decoration: InputDecoration(
                            fillColor: ColorUtils.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: ColorUtils.emailAddressTextFieldColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1, // Set the desired width
                                color: ColorUtils.emailAddressTextFieldColor, // Set the desired color
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(18.0),
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            hintText: "Enter your Email Address",
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          StringUtils.password,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.kiwiMaru(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: ColorUtils.emailAddressTextColor,
                          ),
                        ),
                        TextFormField(
                          cursorColor: ColorUtils.black,
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: ColorUtils.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: ColorUtils.emailAddressTextFieldColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: ColorUtils.emailAddressTextFieldColor,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(18.0),
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            hintText: "Enter your Password",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 60),
                    elevation: 2.0,
                    backgroundColor: ColorUtils.registerButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    StringUtils.signUp,
                    style: GoogleFonts.kiwiMaru(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: ColorUtils.emailAddressTextColor,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringUtils.registerDirectionText,
                  style: GoogleFonts.kiwiMaru(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: ColorUtils.emailAddressTextColor,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () { Navigator.of(context).push(MaterialPageRoute( builder: (context) => const RegisterScreen())); } ,
                  child: Text(
                    StringUtils.registerHereText,
                    style: GoogleFonts.kiwiMaru(
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: ColorUtils.splashScreenTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}