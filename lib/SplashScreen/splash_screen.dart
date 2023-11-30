import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:pharma_trac/HomeScreen/home_screen.dart';
import 'package:pharma_trac/LoginAndRegistration/GoogleSignInApi.dart';
import 'package:pharma_trac/LoginAndRegistration/login_screen.dart';
import 'package:pharma_trac/Utils/colors_utils.dart';
import 'package:pharma_trac/Utils/string_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late Box userDataBox;


  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    var bool = checkWhetherUserIsLoggedInOrNot();
    if (bool){
      print('true');
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      });
    }else{
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      });
      print('False');
    }
    super.initState();
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
            SvgPicture.asset('Icons/logo_final.svg'),
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

  bool checkWhetherUserIsLoggedInOrNot() {
    // TODO: implement checkWhetherUserIsLoggedInOrNot
    userDataBox = Hive.box('userData');
    print(userDataBox);
    String _emailAddress = userDataBox.get('email_address', defaultValue: '');
    print(_emailAddress);
    if (_emailAddress != null && _emailAddress.isNotEmpty){
      return true;
    }
    return false;
  }
}
