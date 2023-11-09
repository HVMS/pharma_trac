import 'package:country_picker/country_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_trac/model/RegisterRequestModel.dart';
import 'package:pharma_trac/services/users_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../HomeScreen/home_screen.dart';
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

  String selectedGender = '';

  bool doubleBackToExitPressedOnce = false;

  String selectedDate = '';

  final TextEditingController _countryController = TextEditingController();
  Country? _selectedCountry;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullNameController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var heightController = TextEditingController();
  var weightController = TextEditingController();

  // Shared Preference to store user Data
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSharedPreference();
  }

  void initializeSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      countryListTheme: const CountryListThemeData(
        bottomSheetHeight: 500,
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.yellowAccent,
            ),
          ),
        ),
      ),
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
          _countryController.text = country.name;
        });
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        // Format the date as desired
        selectedDate = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

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
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              margin: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
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
                                TextField(
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
                                  controller: emailController,
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
                                TextField(
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
                                  controller: fullNameController,
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
                                TextField(
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
                                  controller: passwordController,
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
                                TextField(
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
                                  controller: confirmPasswordController,
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
                                TextField(
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
                                  readOnly: true,
                                  controller: TextEditingController(text: selectedDate),
                                  onTap: () {
                                    _selectDate(context);
                                  },
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
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
                                      return 'Please Select Your Gender.';
                                    }
                                    return value;
                                  },
                                  onChanged: (value) {
                                    //Do something when selected item is changed.
                                    selectedGender = value!;
                                    print(value);
                                  },
                                  onSaved: (value) {
                                    selectedGender = value!;
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
                                TextField(
                                  cursorColor: ColorUtils.black,
                                  onTap: _openCountryPicker,
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
                                  readOnly: true,
                                  controller: _countryController,
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
                                TextField(
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
                                    hintText: "Enter your height (in Ft)",
                                  ),
                                  controller: heightController,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  StringUtils.weight,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.kiwiMaru(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: ColorUtils.emailAddressTextColor,
                                  ),
                                ),
                                TextField(
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
                                    hintText: "Enter your weight (in Kg)",
                                  ),
                                  controller: weightController,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          onPressed: () async {
                            RegisterRequestModel registerRequestModel =
                                RegisterRequestModel(
                                    emailAddress: emailController.text,
                                    password: passwordController.text,
                                    fullName: fullNameController.text,
                                    confirmPassword: confirmPasswordController.text,
                                    birthDate: selectedDate,
                                    gender: selectedGender,
                                    country: _countryController.text,
                                    height: heightController.text,
                                    weight: weightController.text
                                );

                            String? insertedUserId = '';
                            prefs = await SharedPreferences.getInstance();
                            UsersAPI.registerFinal(registerRequestModel).then((response) => {

                              if (response != null){
                                if (response.statusCode == 200){
                                  if (response.user != null){
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(content: Text("User Successfully Registered!!"))),

                                    insertedUserId = response.user?.insertedId.toString(),
                                    prefs.setString('userId', insertedUserId!),

                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (_) => const HomeScreen(),
                                      ),
                                    ),

                                  }
                                }else{
                                  ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(content: Text("User Already Exists!"))),
                                }
                              }
                            });
                          },
                          child: Text(
                            StringUtils.registerText,
                            style: GoogleFonts.kiwiMaru(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600,
                              color: ColorUtils.emailAddressTextColor,
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
        ),
      ),
    );
  }
}

