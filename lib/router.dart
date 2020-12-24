
import 'package:flutter/material.dart';
import 'package:cc16_product_checker/screens/ListView.dart';
import 'package:cc16_product_checker/screens/singleview.dart';

import 'screens/Scan_Results.dart';
import 'screens/Scanner.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var signuparg = settings.arguments;
  var barchode = settings.arguments;

  switch (settings.name) {
    case 'scanResult':
      return MaterialPageRoute(builder: (context) => ScanResults(signuparg));

    case 'listview':
      return MaterialPageRoute(builder: (context) => ListViewe());
    case 'singleview':
      return MaterialPageRoute(builder: (context) => SingleView(barchode));
  }
}