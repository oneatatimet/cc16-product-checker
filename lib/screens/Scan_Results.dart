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
        body: new FutureBuilder<ProductDetails>(
        future: myproduct, // a Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<ProductDetails> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none: return new Text('Press button to start');
            case ConnectionState.waiting: return Center(child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff140257),),

            ));
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return new SingleChildScrollView(
                  child: snapshot.data.status==1?Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20,left: 30,right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                            
                      ),
                          ),
                          SizedBox(height: 15,),
                          Center(
                            child: Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: NetworkImage(snapshot.data.product.imageUrl),
                                  fit: BoxFit.fill
                                )
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Ingredient",style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 25,
                              ),
                              ),
                              Container(

                                child: snapshot.data.product.ingredientsTextEn!=null?Text(snapshot.data.product.ingredientsTextEn,style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                ),):Text("Nothing Found",style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                ),),
                              ),
                              SizedBox(height: 30,),
                              Text("Code",style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 25,
                              ),
                              ),
                              Container(

                                child: snapshot.data.code!=null?Text(snapshot.data.code,style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                ),):Text("Nothing Found",style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                ),),
                              ),
                            ],
                            ),
                           SizedBox(height: 20,),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Color(0xff140257))),
                              onPressed: () {},
                              color: Color(0xff140257),
                              textColor: Colors.white,
                              child: Text("Save Data".toUpperCase(),
                                  style: TextStyle(fontSize: 14)),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Color(0xff140257))),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              color: Color(0xff140257),
                              textColor: Colors.white,
                              child: Text("Scan New".toUpperCase(),
                                  style: TextStyle(fontSize: 14)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ): Container(
                    child: Text("Not Found"),
                  ),

                );
          }
        },
      )
    );

  }
}
