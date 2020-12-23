import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' show FontAwesomeIcons;
import 'package:nice_button/nice_button.dart';


class Scanner extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Scanner> {
  String _scanBarcode = '';

  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
  

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#140257", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
    Navigator.pushNamed(context, 'scanResult',arguments: barcodeScanRes);
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
            backgroundColor:Color(0xff140257),
            title: Center(child: const Text('App'))),
        body: Builder(builder: (BuildContext context) {
          return Container(
              alignment: Alignment.center,
              child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NiceButton(
                      radius: 40,
                      padding: const EdgeInsets.all(15),
                      text: "Start QR scan",
                      icon: FontAwesomeIcons.qrcode,
                      gradientColors: [firstColor,secondColor],
                      onPressed:() => scanQR(), background: null,
                    ),

                    SizedBox(height: 20,),
                    Text('Scan result:',
                        style: TextStyle(fontSize: 20, color: Color(0xff140257), fontWeight: FontWeight.bold)),
                    SizedBox(height: 20,),
                    Text(_scanBarcode,
                        style: TextStyle(fontSize: 20, color: Color(0xff140257), fontWeight: FontWeight.bold))
                  ]));
        }));
  }
}