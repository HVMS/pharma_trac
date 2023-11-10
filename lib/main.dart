import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pharma_trac/SplashScreen/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('userData');

  runApp(
    DevicePreview(
      enabled: kDebugMode,
      builder: (context) => const MyApp(),
    ),
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
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: const SplashScreen(),
    );
  }
}
