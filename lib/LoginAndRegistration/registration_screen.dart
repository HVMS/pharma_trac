import 'package:csc_picker/csc_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/colors_utils.dart';
import '../Utils/string_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final List<String> genderItems = [
    'Male',
    'Female',
    'Transgender',
    'Non-binary',
    'Two-spirit',
  ];

  String? selectedValue;

  String? selectedCountry;

  bool doubleBackToExitPressedOnce = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (doubleBackToExitPressedOnce) {
            // Close the app
            SystemNavigator.pop();
            return false;
          }

          // Show a snack-bar message when back is pressed once
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tap back again to exit'),
            ),
          );

          // Set a timer to reset the double back press flag
          doubleBackToExitPressedOnce = true;
          Future.delayed(const Duration(seconds: 3), () {
            doubleBackToExitPressedOnce = false;
          });

          return false;
        },
        child: Container(
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
          child: SingleChildScrollView(
            child: Column(
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
                            const SizedBox(height: 10.0),
                            Text(
                              StringUtils.fullName,
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
                                    width: 1,
                                    color: ColorUtils.emailAddressTextFieldColor,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(18.0),
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                hintText: "Enter your full name",
                              ),
                            ),
                            const SizedBox(height: 10.0),
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
                                    width: 1, // Set the desired width
                                    color: ColorUtils.emailAddressTextFieldColor, // Set the desired color
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(18.0),
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                hintText: "Enter your password",
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              StringUtils.confirmPassword,
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
                                hintText: "Enter your confirm password",
                              ),
                            ),
                            const SizedBox(height: 10.0),

                            Text(
                              StringUtils.birthDate,
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
                                hintText: "Enter birth date",
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              StringUtils.gender,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.kiwiMaru(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                color: ColorUtils.emailAddressTextColor,
                              ),
                            ),
                            DropdownButtonFormField2<String>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                // Add Horizontal padding using menuItemStyleData.padding so it matches
                                // the menu padding when button's width is not specified.
                                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: ColorUtils.emailAddressTextFieldColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1, // Set the desired width
                                    color: ColorUtils.emailAddressTextFieldColor, // Set the desired color
                                  ),
                                ),
                                // Add more decoration..
                              ),
                              hint: const Text(
                                'Select Your Gender',
                                style: TextStyle(fontSize: 14),
                              ),
                              items: genderItems
                                  .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select gender.';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                //Do something when selected item is changed.
                                // print(value);
                              },
                              onSaved: (value) {
                                selectedValue = value.toString();
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.only(right: 8),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 24,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              StringUtils.countryName,
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
                                    width: 1, // Set the desired width
                                    color: ColorUtils.emailAddressTextFieldColor, // Set the desired color
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(18.0),
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                hintText: "Select your country",
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              StringUtils.height,
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
                                hintText: "Enter your height",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

