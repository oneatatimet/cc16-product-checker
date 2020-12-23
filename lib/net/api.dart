import 'package:cc16_product_checker/models/APImodel.dart';
import 'package:http/http.dart' as http;

class MyApi {
  static final MyApi _singleton = MyApi._internal();

  factory MyApi() {
    return _singleton;
  }

  MyApi._internal();

  Future<ProductDetails> fetchproducts(String code) async {
    String url =
        'https://world.openfoodfacts.org/api/v0/product/' + code + '.json';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final String responsestring = response.body;
      ProductDetails list = productDetailsFromJson(responsestring);
      print(list.product);
      return list;
    } else {
      final String responsestring = response.body;
      ProductDetails list = productDetailsFromJson(responsestring);
      return list;
    }
  }
}
