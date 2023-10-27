import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_trac/HomeScreen/home_screen.dart';
import 'package:pharma_trac/LoginAndRegistration/login_screen.dart';
import 'package:pharma_trac/Utils/colors_utils.dart';
import 'package:pharma_trac/Utils/string_utils.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 3), (){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen(),
        ),
      );
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
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
            const CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('images/Logo1.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                StringUtils.splashScreenCaption,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.kiwiMaru(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w700,
                  color: ColorUtils.splashScreenTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}