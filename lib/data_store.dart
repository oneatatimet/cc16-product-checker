import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:cc16_product_checker/models/APImodel.dart';
import 'package:cc16_product_checker/models/list_productdetails.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Json_Datafetch {
  // base functions to get the list
  Future<String> getfood() {
    print("in datafetch");
    return rootBundle.loadString('assets/foodlist.json');
  }

  filecreators() async {
    var spendings = await getfood();
    List<ListProductDetails> spendinglist =
        listProductDetailsFromJson(spendings);
    Directory directory = await getApplicationDocumentsDirectory();
    var dbPath = join(directory.path, "foodlist.json");
    await File(dbPath)
        .writeAsStringSync(listProductDetailsToJson(spendinglist));
    print("Local spending File created");
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/foodlist.json');
  }

  Future<List<ListProductDetails>> getcontaclist() async {
    final file = await _localFile;
    String contents = await file.readAsString();
    return listProductDetailsFromJson(contents);
  }

  add_spending_data(
      String code, String name, String image, String ingrediants) async {
    final file = await _localFile;
    String date = DateTime.now().toString().substring(0, 10);

    var orderLines = <Map>[]; // creates an empty List<Map>
    orderLines.add({
      "code": code,
      "status": 1,
      "status_verbose": "product found",
      "product": {
        "product_name": name + "",
        "ingredients_text_en": ingrediants + "",
        "image_url": image
      }
    });

    print(orderLines);
    String contents = await file.readAsString();
    List<ListProductDetails> list =
        listProductDetailsFromJson(json.encode(orderLines));
    list.addAll(listProductDetailsFromJson(contents));
    Directory directory = await getApplicationDocumentsDirectory();
    var dbPath = join(directory.path, "foodlist.json");
    print(dbPath);
    await File(dbPath).writeAsStringSync(listProductDetailsToJson(list));
  }
}
