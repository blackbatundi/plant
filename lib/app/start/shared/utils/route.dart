import 'package:flow_projet/app/start/views/start/anounce_page.dart';
import 'package:flow_projet/app/start/views/start/start_page.dart';
import 'package:flow_projet/app/views/home/app_home.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AnouncePage.routeName: (context) => const AnouncePage(),
  StartPage.routeName: (context) => const StartPage(),
  AppHome.routeName: (context) => const AppHome()
};
