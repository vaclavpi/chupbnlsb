import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:honest_guide/model/data_model.dart';

class DataServices {
  Future<List<DataModel>> getCultureInfo() async {
    try {
      // Přečtěte obsah souboru culture_data.json
      final String response =
          await rootBundle.loadString('assets/data/culture_data.json');

      // Dekódujte JSON data do seznamu
      final List<dynamic> list = json.decode(response);

      // Mapujte data na seznam objektů DataModel
      return list.map((e) => DataModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      return <DataModel>[];
    }
  }

  Future<List<DataModel>> getNatureInfo() async {
    try {
      // Přečtěte obsah souboru nature_data.json
      final String response =
          await rootBundle.loadString('assets/data/nature_data.json');

      // Dekódujte JSON data do seznamu
      final List<dynamic> list = json.decode(response);

      // Mapujte data na seznam objektů DataModel
      return list.map((e) => DataModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      return <DataModel>[];
    }
  }

  Future<List<DataModel>> getRefreshmentInfo() async {
    try {
      // Přečtěte obsah souboru food_data.json
      final String response =
          await rootBundle.loadString('assets/data/food_data.json');

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
