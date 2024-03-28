import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:honest_guide/misc/colors.dart';
import 'package:honest_guide/pages/navpages/offline_map.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:honest_guide/cubit/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:honest_guide/model/data_model.dart';

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
  }

  Future<void> _loadMarkerData() async {
    // Load data from the culture_data.json file
    String cultureJsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/data/culture_data.json');
    List<dynamic> cultureJsonData = jsonDecode(cultureJsonString);

    // Load data from the food_data.json file
    String foodJsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/data/food_data.json');
    List<dynamic> foodJsonData = jsonDecode(foodJsonString);

// Load data from the food_data.json file
    String natureJsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/data/nature_data.json');
    List<dynamic> natureJsonData = jsonDecode(natureJsonString);

    // Combine both data lists into one markerData list
    List<dynamic> jsonData = [
      ...cultureJsonData,
      ...foodJsonData,
      ...natureJsonData
    ];

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
        backgroundColor: Colors.white, // Blue color
        child: Icon(
          Icons.close,
          color: AppColors.thirdColor,
        ),
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
            MaterialCommunityIcons.map_marker,
            color: AppColors.fourthColor,
          ),
        ),
      );
    }).toList();
  }
}
