import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pharma_trac/Utils/colors_utils.dart';
import 'package:pharma_trac/Utils/string_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharma_trac/services/users_api.dart';

import '../UserProfile/user_profile_screen.dart';
import '../VitalSigns/vital_signs.dart';
import '../model/User/UserInformation.dart';

class NavigationBarScreen extends StatelessWidget {
  const NavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const MaterialApp(home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentIndex = 0;

  late UserInformationUser informationUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    informationUser = UserInformationUser();
    getUserIdFromSharedPreference().then((userId) {
      print(userId);
      callApiToGetUserInformation(userId);
    }).catchError((error) {
      print(error);
      // Handle the error, e.g., show an error message to the user.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.appBackgroundColor,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        height: 65.0,
        backgroundColor: ColorUtils.navBackgroundColor,
        selectedIndex: currentIndex,
        indicatorColor: ColorUtils.bottomNavigationItemColor,
        destinations: <Widget>[
          NavigationDestination(icon: SvgPicture.asset('Icons/analytics_icon.svg'), label: StringUtils.analytics),
          NavigationDestination(icon: SvgPicture.asset('Icons/add_icon.svg'), label: StringUtils.adr),
          NavigationDestination(icon: SvgPicture.asset('Icons/chat_icon.svg'), label: StringUtils.chat),
          NavigationDestination(icon: SvgPicture.asset('Icons/vital_sign_icon.svg'), label: StringUtils.vitals),
          NavigationDestination(icon: SvgPicture.asset('Icons/user_profile.svg'), label: StringUtils.profile),
        ],
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const Text('Page 1'),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
        const VitalSigns(),
        const UserProfileScreen(),
      ][currentIndex],
    );
  }

  void callApiToGetUserInformation(String userId) async {
    try {
      UserInformation userData = await UsersAPI.getUserInformation(userId);

      var userDataBox = await Hive.openBox(StringUtils.userDataBox);

      UserInformationUser? user = userData.user;
      if (user != null){
        user.toJson().forEach((key, value) async {
          await userDataBox.put(key, value);
        });
      }

    } on Exception catch (e) {
      // TODO
      print(e);
      throw Exception('Error is here');
    }
  }

  getUserIdFromSharedPreference() async {
    String userId = '654bcc54e7961b0091df46be';
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? userId = prefs.getString('userId');
    if (userId != null) {
      return userId;
    } else {
      // You should handle the case where 'userId' is not found in SharedPreferences.
      // You can return a default value or handle it according to your requirements.
      // For example, you can throw an exception if 'userId' is not found.
      throw Exception("userId not found in SharedPreferences");
    }
  }
}
