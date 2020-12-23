import 'package:flutter/material.dart';
import 'package:cc16_product_checker/models/APImodel.dart';
import 'package:cc16_product_checker/net/api.dart';

// ignore: must_be_immutable
class ScanResults extends StatefulWidget {
  String product;
  @override
  _ScanResultsState createState() => _ScanResultsState();
  ScanResults(this.product);
}

class _ScanResultsState extends State<ScanResults> {
  MyApi api = new MyApi();
  Future<ProductDetails> myproduct;
  @override
  void initState() {
    myproduct = api.fetchproducts(widget.product);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff140257),
          title: Text("Product Details"),
        ),
        body:Text("products screen printed")
        );
  }
}
