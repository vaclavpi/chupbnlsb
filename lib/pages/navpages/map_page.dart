import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:honest_guide/pages/navpages/offline_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:honest_guide/cubit/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:honest_guide/model/data_model.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Map<String, dynamic>> markerData = [];
  late OfflineMapController offlineMapController;
  late LatLng currentLocation;

  @override
  void initState() {
    super.initState();
    sqfliteFfiInit();
    offlineMapController = OfflineMapController();
    _loadMarkerData();
    _getCurrentLocation(); // Get the current location when the widget is initialized
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

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high); // Get the current location
    setState(() {
      currentLocation = LatLng(
          position.latitude, position.longitude); // Update the current location
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          // ignore: deprecated_member_use
          center: LatLng(50.19459, 14.67228), // Map's default center position
          // ignore: deprecated_member_use
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

      DataModel dataModel = DataModel.fromJson(data);

      return Marker(
        width: 30.0,
        height: 30.0,
        point: LatLng(latitude, longitude),
        child: GestureDetector(
          onTap: () {
            BlocProvider.of<AppCubits>(context).DetailPage(dataModel);
          },
          child: Icon(
            Icons.location_on,
            color: Colors.red,
          ),
        ),
      );
    }).toList();
  }
}
