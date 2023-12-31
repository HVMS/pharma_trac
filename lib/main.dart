import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pharma_trac/SplashScreen/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('userDataBox');

  runApp(
    const MyApp()
    // DevicePreview(
    //   enabled: kDebugMode,
    //   builder: (context) => const MyApp(),
    // ),
  );
}

class MyApp extends StatefulWidget  {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState()=> _MyApp();
}

class _MyApp extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      home: SplashScreen(),
    );
  }
}
