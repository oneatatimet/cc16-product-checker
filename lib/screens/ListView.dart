
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cc16_product_checker/models/list_productdetails.dart';

import '../data_store.dart';
class ListViewe extends StatefulWidget {
  @override
  _ListViewState createState() => _ListViewState();
}

class _ListViewState extends State<ListViewe> {
  Future<List<ListProductDetails>> mylist;
  Json_Datafetch obj=new Json_Datafetch();
  @override
  void initState() {
    mylist=obj.getcontaclist();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("ProductList",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          fontFamily: "Poppins"
        ),)
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
color: Colors.white,
        child: Column(
          children: [

            Expanded(
              child: FutureBuilder<List<ListProductDetails>>(
                future: mylist, // a Future<String> or null
                builder: (BuildContext context, AsyncSnapshot<List<ListProductDetails>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none: return new Text('Press button to start');
                    case ConnectionState.waiting: return new Text('Awaiting result...');
                    default:
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      else
                        return ListView.separated(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return itembuilder(snapshot.data[index].product.imageUrl,snapshot.data[index].product.productName,
                              snapshot.data[index].code,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10,);
                          },
                        );
                  }
                },
              )
            )

          ],
        ),
      ),
    );
  }

  Widget itembuilder(String im,String name,String code){
    return   Container(
      height: 90,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFF000000).withOpacity(.2),
            blurRadius: 10.0,
            spreadRadius:1.0,
            offset: Offset(
              0.0,
              5.0,
            ),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),

      ),
      child: Row(
        children: [
          Expanded(child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 80,
              width: 60,
              decoration: BoxDecoration(
                image: im!=null?DecorationImage(
                    image: NetworkImage(im),
                    fit: BoxFit.contain
                ):DecorationImage(
                    image: AssetImage("assets/notfound.png"),
                    fit: BoxFit.contain
                ),
                borderRadius: BorderRadius.all(Radius.circular(08)),

              ),

            ),
          ),
            flex: 4,

          ),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: "Poppins",
                    fontSize: 16,
                  ),),
              ),
              Container(
                child: Text(code,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: "Poppins",
                    fontSize: 13,
                  ),),
              ),

            ],
          ),
            flex: 6,),
          Expanded(child: Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Container(

              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(05.0),
                    side: BorderSide(color:  Color(0xff140257))),
                onPressed: () {
                  Navigator.pushNamed(context, 'singleview',arguments: code);

                },
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,

                child: Text("View".toUpperCase(),
                    style: TextStyle(fontSize: 14)),
              ),
            ),
          ),
            flex: 4,)
        ],
      ),
    );
}


}
