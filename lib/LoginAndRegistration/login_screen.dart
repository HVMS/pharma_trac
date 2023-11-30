import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:pharma_trac/HomeScreen/home_screen.dart';
import 'package:pharma_trac/LoginAndRegistration/registration_screen.dart';
import 'package:pharma_trac/Utils/string_utils.dart';
import '../Utils/colors_utils.dart';
import '../model/User/login_user_response.dart';
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
                SvgPicture.asset('Icons/logo_final.svg'),
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          callAPIToLogin();
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
                          }),
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

    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Sign in failed')));
    } else {
      print(user.toString());

      // my user response is like this
      //{
      //  displayName: Viral Siddhapura Mukundbhai, email: viralsid2330@gmail.com,id: 112204835519975761927,
      //  photoUrl: https://lh3.googleusercontent.com/a/ACg8ocI2s3sRNQgpBqZtVN3ds3YEdMzxHio1wtfK0OxD78NY81Q, serverAuthCode: null
      //}

      // Now store user information
      late Box box;
      box = await Hive.openBox('userData');
      box.put('email_address', user.email.toString());
      box.put('fullName', user.displayName.toString());
      box.put('_id', user.id.toString());
      box.put('photoUrl', user.photoUrl.toString());

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Sign in Successful, please wait redirecting to Home Page')));

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    }
  }

  Future<void> callAPIToLogin() async {
    LoginUser loginUserResponse = await UsersAPI.login(
        emailController.text.toString(), passwordController.text.toString());

    print('Full API response: ${loginUserResponse.toJson()}');

    String successMessage = "";

    if (loginUserResponse.statusCode == 200) {
      if (loginUserResponse.message != null) {
        successMessage = loginUserResponse.message.toString();

        LoginUserResponse? userResponse = loginUserResponse.response;

        // Now store user information
        if (userResponse != null) {
          print("right");

          // Store the userInformation data into Hive
          late Box box;
          box = await Hive.openBox('userInformation');
          box.put('userInformation', userResponse);

          print(userResponse.toString());
          print("hive data ==> ${box.get('userInformation')}");

          Fluttertoast.showToast(
            msg: successMessage,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0,
          );

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
          );
        } else {
          print("Wrong information entered");
        }
      }
    } else if (loginUserResponse.statusCode == 404) {
      if (loginUserResponse.message != null) {
        successMessage = loginUserResponse.message.toString();
      }
      Fluttertoast.showToast(
        msg: successMessage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
      );
    }
  }
}
