import 'package:flutter/material.dart';
import 'package:cc16_product_checker/data_store.dart';
import 'screens/Scanner.dart';
import 'package:cc16_product_checker/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('check');
  if(email=='yes'){
    runApp(MyApp());
  }
  else{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('check', 'yes');
    Json_Datafetch obj=new Json_Datafetch();
    obj.filecreators();
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Checker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff140257),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          backgroundColor: Colors.white,

      ),
      home: Scanner(),
      onGenerateRoute: generateRoute,

    );
  }
}


