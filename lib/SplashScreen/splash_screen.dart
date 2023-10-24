import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.lightBlueAccent,
              Colors.deepPurpleAccent,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const CircleAvatar(
              backgroundImage: AssetImage('images/Logo1.png'),
              radius: 150,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Safe guarding Against Adverse Drug Reactions',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: GoogleFonts.kiwiMaru(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w700,
                  color: HexColor('#FAF000'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}