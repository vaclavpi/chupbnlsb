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
import 'package:location/location.dart' as loc;

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Map<String, dynamic>> markerData = [];
  late OfflineMapController offlineMapController;
  late LatLng currentLocation = LatLng(50.19459, 14.67228); // Default location
  String selectedDatabase = 'Vše'; // Default selected database

  @override
  void initState() {
    super.initState();
    sqfliteFfiInit();
    offlineMapController = OfflineMapController();
    _loadMarkerData();
    _getCurrentLocation(); // Get current location when initializing
  }

  Future<void> _getCurrentLocation() async {
    loc.Location location = loc.Location();

    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;
    loc.LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {
      currentLocation =
          LatLng(_locationData.latitude!, _locationData.longitude!);
    });
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

    // Load data from the nature_data.json file
    String natureJsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/data/nature_data.json');
    List<dynamic> natureJsonData = jsonDecode(natureJsonString);

    // Combine all data lists according to selected database
    List<dynamic> jsonData = [];
    if (selectedDatabase == 'Vše') {
      jsonData = [...cultureJsonData, ...foodJsonData, ...natureJsonData];
    } else if (selectedDatabase == 'Kulturní památky') {
      jsonData = [...cultureJsonData];
    } else if (selectedDatabase == 'Občerstvení') {
      jsonData = [...foodJsonData];
    } else if (selectedDatabase == 'Příroda a odpočinková místa') {
      jsonData = [...natureJsonData];
    }

    // Save data into the markerData list
    setState(() {
      markerData = List<Map<String, dynamic>>.from(jsonData);
    });

    await offlineMapController.downloadMapTiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: currentLocation,
              zoom: 16.0,
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
          Positioned(
            top: 50.0,
            right: 16.0,
            child: SizedBox(
              width: 64.0,
              height: 64.0,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    color: AppColors.thirdColor,
                    size: 32.0,
                  ),
                  onPressed: () {
                    _showDatabaseSelectionDialog();
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 50.0,
            left: 16.0,
            child: SizedBox(
              width: 64.0,
              height: 64.0,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(
                    Icons.home,
                    color: AppColors.thirdColor,
                    size: 32.0,
                  ),
                  onPressed: () {
                    BlocProvider.of<AppCubits>(context).goHome();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Marker> _buildMarkers() {
    List<Marker> markers = [];

    // Add markers from markerData list
    markers.addAll(markerData
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
    }).toList());

    // Add marker for current location
    markers.add(Marker(
      width: 30.0,
      height: 30.0,
      point: currentLocation,
      child: Icon(
        Icons.navigation_rounded,
        color: Colors.blue,
      ),
    ));

    return markers;
  }

  void _showDatabaseSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Zvolte filtr'),
          content: DropdownButton<String>(
            value: selectedDatabase,
            items: <String>[
              'Vše',
              'Kulturní památky',
              'Občerstvení',
              'Příroda a odpočinková místa'
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedDatabase = newValue;
                  _loadMarkerData();
                  Navigator.of(context).pop();
                });
              }
            },
          ),
        );
      },
    );
  }
}
