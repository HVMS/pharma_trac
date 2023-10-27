import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Utils/colors_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

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

          // Show a snackbar message when back is pressed once
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
        ),
      ),
    );
  }
}
