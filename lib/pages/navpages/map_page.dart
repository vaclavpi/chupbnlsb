import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  LocationData _currentLocation;
  MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    var location = Location();

    try {
      var currentLocation = await location.getLocation();
      setState(() {
        _currentLocation = currentLocation;
      });
    } catch (e) {
      print("Chyba při získávání polohy: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mapa s aktuální polohou'),
        ),
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(0, 0), // Výchozí střed mapy
            zoom: 13.0, // Výchozí zoom
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(
              markers: _currentLocation != null
                  ? [
                      Marker(
                        width: 40.0,
                        height: 40.0,
                        point: LatLng(
                            _currentLocation.latitude, _currentLocation.longitude),
                        builder: (ctx) => Container(
                          child: Icon(
                            Icons.location_on,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ]
                  : [],
            ),
          ],
          mapController: _mapController,
        ),
      ),
    );
  }
}
