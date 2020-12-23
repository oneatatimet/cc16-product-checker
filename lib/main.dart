import 'package:flutter/material.dart';
import 'screens/Scanner.dart';
import 'package:cc16_product_checker/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diet Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          backgroundColor: Colors.white,

      ),
      home: Scanner(),
      onGenerateRoute: generateRoute,

    );
  }
}

