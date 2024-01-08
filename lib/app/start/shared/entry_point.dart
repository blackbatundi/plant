import 'dart:io';
import 'package:flow_projet/app/start/shared/utils/route.dart';
import 'package:flow_projet/app/start/shared/utils/style.dart';
import 'package:flow_projet/app/start/views/start/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlantApp extends StatefulWidget {
  const PlantApp({Key? key}) : super(key: key);
  @override
  State<PlantApp> createState() => _PlantAppState();
}

class _PlantAppState extends State<PlantApp> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Style.themeData(false, context),
      routes: routes,
      home: const SplashScreen(),
    );
  }
}
