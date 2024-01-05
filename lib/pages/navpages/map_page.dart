import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:honest_guide/pages/navpages/offline_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:honest_guide/cubit/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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
    // Load data from the data.json file
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/data/data.json');
    List<dynamic> jsonData = jsonDecode(jsonString);

    // Save data into the markerData list
    setState(() {
      markerData = List<Map<String, dynamic>>.from(jsonData);
    });

    await offlineMapController.downloadMapTiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(50.19459, 14.67228), // Map's default center position
          zoom: 16.0, // Map's default zoom
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
          // Function that is called when the button is pressed
          // Here you can add the code to navigate back to the homescreen
          BlocProvider.of<AppCubits>(context).goHome();
        },
        backgroundColor: Colors.blue, // Blue color
        child: Icon(Icons.close),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  List<Marker> _buildMarkers() {
    return markerData
        .where((data) => data['latitude'] != null && data['longitude'] != null)
        .map((data) {
      double latitude = data['latitude'] ?? 0.0;
      double longitude = data['longitude'] ?? 0.0;

      return Marker(
        width: 30.0,
        height: 30.0,
        point: LatLng(latitude, longitude),
        child: build(
          (BuildContext context) {
            return Container(
              child: Icon(
                Icons.location_on,
                color: Colors.red,
              ),
            );
          } as BuildContext,
        ),
      );
    }).toList();
  }
}
