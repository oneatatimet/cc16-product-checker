import 'package:http/http.dart' as http;

class MyApi {
  static final MyApi _singleton = MyApi._internal();

  factory MyApi() {
    return _singleton;
  }

  MyApi._internal();

  Future fetchproducts(String code) async {
    String url =
        'https://world.openfoodfacts.org/api/v0/product/' + code + '.json';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final String responsestring = response.body;
      print(responsestring);
    } else {
      print("not working");
    }
  }
}
