import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:honest_guide/misc/colors.dart';
import 'package:honest_guide/pages/navpages/offline_map.dart';
import 'package:honest_guide/widgets/app_bold_text.dart';
import 'package:honest_guide/widgets/app_large_bold_text.dart';
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
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      AppLargeText(
                        text: "Prozkoumej",
                        size: 35,
                        color: AppColors.fourthColor,
                      ),
                      AppBoldText(
                        text: "Brandýs nad Labem-Starou Boleslav",
                        size: 16,
                        color: AppColors.fourthColor,
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/img/logoTB.png',
                    width: 107,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 180.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                _showDatabaseSelectionDialog();
              },
              child: Icon(Icons.filter_alt),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Divider(height: 0),
                  BottomNavigationBar(
                    currentIndex: 1,
                    onTap: (int index) {
                      final appCubits = BlocProvider.of<AppCubits>(context);
                      if (index == 0) {
                        appCubits.goHome();
                      } else if (index == 1) {
                        appCubits.MapPage();
                      } else if (index == 2) {
                        appCubits.MapPage();
                      } else if (index == 3) {
                        appCubits.goAbout();
                      }
                    },
                    selectedItemColor: AppColors.fourthColor,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.place,
                          color: AppColors.thirdColor,
                        ),
                        label: 'Místa',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.map,
                          color: AppColors.thirdColor,
                        ),
                        label: 'Mapa',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.favorite,
                          color: AppColors.thirdColor,
                        ),
                        label: 'Oblíbené',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.more_horiz,
                          color: AppColors.thirdColor,
                        ),
                        label: 'Více',
                      ),
                    ],
                  ),
                ],
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
