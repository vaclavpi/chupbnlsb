import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:honest_guide/model/data_model.dart';

class DataServices {
  Future<List<DataModel>> getInfo() async {
    try {
      // Přečtěte obsah souboru data.json
      final String response =
          await rootBundle.loadString('assets/data/data.json');

      // Dekódujte JSON data do seznamu
      final List<dynamic> list = json.decode(response);

      // Mapujte data na seznam objektů DataModel
      return list.map((e) => DataModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      return <DataModel>[];
    }
  }
}
