import 'package:flutter/material.dart';
import 'screens/Scan_Results.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  var signuparg=settings.arguments;
  switch (settings.name) {
    case 'scanResult':
      return MaterialPageRoute(builder: (context) => ScanResults(signuparg));
  }
}