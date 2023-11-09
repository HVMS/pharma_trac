import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_trac/LoginAndRegistration/registration_screen.dart';
import 'package:pharma_trac/Utils/string_utils.dart';
import 'package:pharma_trac/model/user.model.dart';

import '../Utils/colors_utils.dart';
import '../services/users_api.dart';
import 'GoogleSignInApi.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SvgPicture.asset('Icons/app_logo.svg'),
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
                                      color:
                                          ColorUtils.emailAddressTextFieldColor,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1, // Set the desired width
                                      color: ColorUtils
                                          .emailAddressTextFieldColor, // Set the desired color
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.all(18.0),
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                  hintText: "Enter your Email Address",
                                ),
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  } else if (!isValidEmail(value)) {
                                    return 'Invalid email format';
                                  }
                                }),
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
                                    color:
                                        ColorUtils.emailAddressTextFieldColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color:
                                        ColorUtils.emailAddressTextFieldColor,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(18.0),
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                hintText: "Enter your Password",
                              ),
                              controller: passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password cannot be empty';
                                } else if (value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                } else if (!isStrongPassword(value)) {
                                  return 'Password must contain at least one uppercase, one lowercase, one number, and an underscore.';
                                } else {
                                  return null;
                                }
                              },
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          UserRegisterRequestModel userRegisterRequestModel =
                          UserRegisterRequestModel(
                            emailAddress: emailController.text,
                            password: passwordController.text,
                          );

                          UsersAPI.register(userRegisterRequestModel)
                              .then((response) {
                            print(response);
                            print(response.runtimeType);
                            if (response is String) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Registration failed: $response"),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Registration successful"),
                                ),
                              );
                            }
                          });
                        }
                      },
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: ColorUtils.white,
                      child: IconButton(
                        icon: SvgPicture.asset('Icons/google_signin.svg'),
                        onPressed: () {
                          googleAuthenticationProvider();
                        }
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
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
                      },
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
            )),
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    return emailRegExp.hasMatch(email) && email.contains('@');
  }

  bool isStrongPassword(String password) {
    // Check if the password contains at least one uppercase letter, one lowercase letter,
    // one number, and an underscore.
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);

    return hasUppercase && hasLowercase && hasNumber;
  }

  Future googleAuthenticationProvider() async {
    var user = await GoogleSignInApi.login();

    if (user == null){
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Sign in failed')));
    }else{
      print(user.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Sign in Successful, please wait redirecting to Home Page')));
    }

  }
}
