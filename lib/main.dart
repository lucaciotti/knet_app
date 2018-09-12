import 'package:flutter/material.dart';
// import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:knet_app/routes.dart';

import 'package:knet_app/pages/landing_page.dart';


void main() {
  runApp(new MaterialApp(
    home: new LandingPage(),
    theme: ThemeData(
      fontFamily: 'PT_Sans_Narrow',
      primarySwatch: Colors.lightGreen,
      ),
    routes: routes,
  ));
}