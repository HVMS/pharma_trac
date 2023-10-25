import 'package:flutter/material.dart';
import 'package:pharma_trac/Utils/colors_utils.dart';
import 'package:pharma_trac/Utils/string_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../UserProfile/user_profile_screen.dart';

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
        Container(
          alignment: Alignment.center,
          child: const Text('Page 4'),
        ),
        const UserProfileScreen(),
      ][currentIndex],
    );
  }
}
