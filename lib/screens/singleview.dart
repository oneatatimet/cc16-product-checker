import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cc16_product_checker/data_store.dart';
import 'package:cc16_product_checker/models/APImodel.dart';
import 'package:cc16_product_checker/models/details_model.dart';
import 'package:cc16_product_checker/net/api.dart';

// ignore: must_be_immutable
class SingleView extends StatefulWidget {
  String product;
  @override
  _ScanResultsState createState() => _ScanResultsState();
  SingleView(this.product);
}

class _ScanResultsState extends State<SingleView> {
  MyApi api=new MyApi();
  Future<ProductDetails> myproduct;
  @override
  void initState() {
    myproduct=api.fetchproducts(widget.product);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:Color(0xff140257),
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
                                child: Text( snapshot.data.product.productName,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "Poppins",
                                  ),),
                              ),
                            ),
                            SizedBox(height: 15,),
                            Center(
                              child: snapshot.data.product.imageUrl!=null?Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot.data.product.imageUrl),
                                        fit: BoxFit.fill
                                    )
                                ),
                              ):Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                        image: AssetImage("assets/notfound.png"),
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
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                color: Color(0xff140257),
                                textColor: Colors.white,
                                child: Text("Back".toUpperCase(),
                                    style: TextStyle(fontSize: 14)),
                              ),
                            ),



                          ],
                        ),
                      ),
                    ): Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              child: SvgPicture.asset("assets/error.svg"),
                            ),
                            SizedBox(height: 20,),
                            Text("Not Found",style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Poppins"
                            ),),
                          ],
                        )
                    ),

                  );
            }
          },
        )
    );

  }
}
