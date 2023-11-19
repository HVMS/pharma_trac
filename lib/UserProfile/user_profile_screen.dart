import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pharma_trac/UserProfile/edit_profile_screen.dart';
import 'package:pharma_trac/Utils/colors_utils.dart';
import 'package:pharma_trac/Utils/string_utils.dart';
import 'package:flutter_svg/svg.dart';

import '../Utils/styleUtils.dart';
import '../customWidgets/CustomGreyDivider.dart';

class UserProfileScreen extends StatefulWidget{

  const UserProfileScreen({super.key});

  @override
  State<StatefulWidget> createState()=> _UserProfileScreen();

}

class _UserProfileScreen extends State<UserProfileScreen>{

  late Box<dynamic> userDataBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDataBox = Hive.box<dynamic>('userData');
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
                  CircleAvatar(
                    backgroundColor: ColorUtils.grey,
                    radius: 50,
                    child: SvgPicture.asset('Icons/user_profile1.svg'),
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
                      Navigator.push(context, MaterialPageRoute(
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
                      const SizedBox(width: 15.0,),
                      Text(
                        StringUtils.userChangePassword,
                        style: StyleUtils.robotoTextStyle(),
                      ),
                    ],
                  ),
                  onTap: (){
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
                      const SizedBox(width: 15.0,),
                      Text(
                        StringUtils.userRatings,
                        style: StyleUtils.robotoTextStyle(),
                      ),
                    ],
                  ),
                  onTap: (){

                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset('Icons/logout_icon.svg'),
                      const SizedBox(width: 15.0,),
                      Text(
                        StringUtils.userLogout,
                        style: StyleUtils.robotoTextStyle(),
                      ),
                    ],
                  ),
                  onTap: (){

                  },
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                const Text('New password', style: TextStyle(fontSize: 20, color: Colors.black)),
                const Text('Your passwords must be at least 8 characters long, and contain at least one letter and one digit', textAlign: TextAlign.center),
                TextField(
                  controller: passwordController,
                  obscureText: !passwordVisible,
                  onChanged: (value) {
                    setState(() {
                      _isPasswordMatched = passwordController.text == confirmController.text;
                    });
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                TextField(
                  controller: confirmController,
                  obscureText: !confirmVisible,
                  onChanged: (value) {
                    setState(() {
                      _isPasswordMatched = passwordController.text == confirmController.text;
                    });
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(confirmVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          confirmVisible = !confirmVisible;
                        });
                      },
                    ),
                  ),
                ),
                buildValidationRow(hasEightCharacters, 'Has at least 8 characters'),
                buildValidationRow(hasDigit, 'Has one digit'),
                buildValidationRow(hasLetter, 'Has one letter'),
                ElevatedButton(
                  onPressed: _isPasswordMatched ? () {} : null,
                  child: const Text('Update'),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildValidationRow(ValueNotifier<bool> validationNotifier, String text) {
    return ValueListenableBuilder(
      valueListenable: validationNotifier,
      builder: (context, isValid, child) {
        return Row(
          children: [
            Icon(isValid ? Icons.check_circle_rounded : Icons.cancel_rounded, color: isValid ? Colors.green : Colors.red),
            const SizedBox(width: 10),
            Text(text),
          ],
        );
      },
    );
  }
}


