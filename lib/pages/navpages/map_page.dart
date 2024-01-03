import 'dart:convert';
import 'offline_map.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:honest_guide/cubit/app_cubit.dart';
import 'package:latlong2/latlong.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:honest_guide/pages/detail_page.dart ';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Map<String, dynamic>> markerData = [];
  late OfflineMapController offlineMapController;

  @override
  void initState() {
    super.initState();
    sqfliteFfiInit();
    offlineMapController = OfflineMapController();
    _loadMarkerData();
  }

  Future<void> _loadMarkerData() async {
    // Načtení dat ze souboru data.json
    String jsonString =
        await DefaultAssetBundle.of(context).loadString('assets/data/data.json');
    List<dynamic> jsonData = jsonDecode(jsonString);

    // Uložení dat do seznamu markerData
    setState(() {
      markerData = List<Map<String, dynamic>>.from(jsonData ?? []);
    });

    await offlineMapController.downloadMapTiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(50.19459, 14.67228), // Výchozí pozice mapy
          zoom: 16.0, // Výchozí zoom
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: _buildMarkers(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Funkce, která se vyvolá po stisknutí tlačítka
          // Zde můžete přidat kód na návrat na homescreen
          BlocProvider.of<AppCubits>(context).goHome();
        },
        backgroundColor: Colors.blue, // Barva modrá
        child: Icon(Icons.close),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  List<Marker> _buildMarkers() {
    return markerData
        .where((data) =>
            data['latitude'] != null && data['longitude'] != null)
        .map((data) {
      double latitude = data['latitude'] ?? 0.0;
      double longitude = data['longitude'] ?? 0.0;

      return Marker(
        width: 30.0,
        height: 30.0,
        point: LatLng(latitude, longitude),
        child: builder: (BuildContext context){

        },
        child: Container(
          child: Icon(
            Icons.location_on,
            color: Colors.red,
          ),
        ),
      );
    }).toList();
  }
}
