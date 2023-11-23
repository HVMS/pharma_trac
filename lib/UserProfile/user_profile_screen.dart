import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharma_trac/UserProfile/edit_profile_screen.dart';
import 'package:pharma_trac/Utils/colors_utils.dart';
import 'package:pharma_trac/Utils/string_utils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma_trac/services/users_api.dart';

import '../Utils/styleUtils.dart';
import '../customWidgets/CustomGreyDivider.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UserProfileScreen();
}

class _UserProfileScreen extends State<UserProfileScreen> {
  late Box userDataBox;
  String userId = "";

  String imageURL = '';
  bool isUploading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDataBox = Hive.box('userData');
    userId = userDataBox.get("_id", defaultValue: '');
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
                style: StyleUtils.robotoTextStyle(),
              ),
              const SizedBox(height: 20),
              const CustomGreyDivider(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      print("hello world");
                      callImageUploadFunction();
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: ColorUtils.grey,
                          radius: 50,
                          backgroundImage:
                              imageURL != '' ? NetworkImage(imageURL) : null,
                          child: imageURL == ''
                              ? SvgPicture.asset('Icons/user_profile1.svg')
                              : null,
                        ),
                        if (isUploading) const CircularProgressIndicator(),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        userDataBox.get('fullName', defaultValue: ''),
                        style: StyleUtils.robotoTextStyle(),
                      ),
                      Text(
                        userDataBox.get('email_address', defaultValue: ''),
                        style: StyleUtils.robotoTextStyle(),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: SvgPicture.asset('Icons/edit_icon.svg'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfileScreen()));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const CustomGreyDivider(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset('Icons/password_icon.svg'),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        StringUtils.userChangePassword,
                        style: StyleUtils.robotoTextStyle(),
                      ),
                    ],
                  ),
                  onTap: () {
                    callChangePasswordWidget();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset('Icons/rating_icon.svg'),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        StringUtils.userRatings,
                        style: StyleUtils.robotoTextStyle(),
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset('Icons/logout_icon.svg'),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        StringUtils.userLogout,
                        style: StyleUtils.robotoTextStyle(),
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void callChangePasswordWidget() {
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmController = TextEditingController();
    ValueNotifier<bool> hasEightCharacters = ValueNotifier<bool>(false);
    ValueNotifier<bool> hasDigit = ValueNotifier<bool>(false);
    ValueNotifier<bool> hasLetter = ValueNotifier<bool>(false);
    ValueNotifier<bool> passwordsMatch = ValueNotifier<bool>(false);

    bool _isPasswordMatched = false;

    bool passwordVisible = false;
    bool confirmVisible = false;

    void checkPasswordsMatch() {
      passwordsMatch.value = passwordController.text == confirmController.text;
    }

    passwordController.addListener(() {
      String password = passwordController.text;
      hasEightCharacters.value = password.length >= 8;
      hasDigit.value = password.contains(RegExp(r'\d'));
      hasLetter.value = password.contains(RegExp(r'[a-zA-Z]'));
      checkPasswordsMatch();
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Your passwords must be at least 8 characters long, and contain at least one letter and one digit',
                        style: StyleUtils.changePasswordBottomSheetStyle(),
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        maxLines: 3,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "New Password",
                      textAlign: TextAlign.start,
                      style: StyleUtils.changePasswordBottomSheetStyle(),
                    ),
                  ],
                ),
                TextField(
                  controller: passwordController,
                  obscureText: !passwordVisible,
                  onChanged: (value) {
                    setState(() {
                      _isPasswordMatched =
                          passwordController.text == confirmController.text;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: StringUtils.changePasswordHintText,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: passwordVisible ? Colors.black : Colors.black),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Confirm New Password",
                      textAlign: TextAlign.start,
                      style: StyleUtils.changePasswordBottomSheetStyle(),
                    ),
                  ],
                ),
                TextField(
                  controller: confirmController,
                  obscureText: !confirmVisible,
                  onChanged: (value) {
                    setState(() {
                      _isPasswordMatched =
                          passwordController.text == confirmController.text;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: StringUtils.changeConfirmPasswordHintText,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                          confirmVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: confirmVisible ? Colors.black : Colors.black),
                      onPressed: () {
                        setState(() {
                          confirmVisible = !confirmVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                buildValidationRow(
                    hasEightCharacters, StringUtils.characterPasswordHint),
                buildValidationRow(hasDigit, StringUtils.digitPasswordHint),
                buildValidationRow(hasLetter, StringUtils.letterPasswordHint),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 60),
                    elevation: 2.0,
                    backgroundColor: ColorUtils.registerButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: _isPasswordMatched &&
                          hasDigit.value &&
                          hasEightCharacters.value &&
                          hasLetter.value
                      ? () {
                          callAPIToChangePassword(
                              passwordController.text.toString(),
                              confirmController.text.toString());
                        }
                      : null,
                  child: Text(
                    StringUtils.update,
                    style: GoogleFonts.kiwiMaru(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: ColorUtils.emailAddressTextColor,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildValidationRow(
      ValueNotifier<bool> validationNotifier, String text) {
    return ValueListenableBuilder(
      valueListenable: validationNotifier,
      builder: (context, isValid, child) {
        return Row(
          children: [
            Icon(isValid ? Icons.check_circle_rounded : Icons.cancel_rounded,
                color: isValid ? Colors.green : Colors.red),
            const SizedBox(width: 10),
            Text(text),
          ],
        );
      },
    );
  }

  void callAPIToChangePassword(String password, String confirmPassword) async {
    String message =
        await UsersAPI.changePassword(userId, password, confirmPassword);
    print(message);
    Navigator.pop(context);
  }

  void callImageUploadFunction() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(
        source: ImageSource.gallery);

    print('${file?.path}');

    if (file == null) return;
    try {
      print("Successfully uploaded an image 1 ");
      // Upload the image to Firebase Storage
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('userIdImage+$userId');

      print("Successfully uploaded an image 2");
      await ref.putFile(File(file.path));

      print("Successfully uploaded an image 3");

      setState(() {
        isUploading = true;
      });

      // Get the download URL
      final url = await ref.getDownloadURL();

      setState(() {
        imageURL = url;
        isUploading = false;
      });

      print("URL is here");
      print(imageURL);
    } catch (e) {
      print("Error is here ==>>");
      print(e);
    }
  }
}
