// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// State class for RidePage
class _RidePageState extends State<RidePage> {
  // Declaring variables for openPopups, LayerLink, and openDropdown
  late List<(int, int, String)> openPopups;
  late final LayerLink _link;
  late bool _openDropdown;

  // Initializing the state
  @override
  void initState() {
    openPopups = [];
    _link = LayerLink();
    _openDropdown = false;
    super.initState();
  }

  // Building the widget
  @override
  Widget build(BuildContext context) {
    // Getting MediaQueryData
    MediaQueryData mediaQuery = MediaQuery.of(context);
    // Returning a Center widget
    return Center(
      child: Column(
        children: [
          // Providing some space
          const SizedBox(height: 50,),
          // TextField for entering location
          const TextField(
            decoration: InputDecoration(
              hintText: 'Enter Location',
            ),
          ),
          // SizedBox containing a Stack of FlutterMap and a Text widget
          SizedBox(
            width: mediaQuery.size.width,
            height: mediaQuery.size.height*.75,
            child: Stack(children: [
              // FlutterMap widget
              FlutterMap(
                options: MapOptions(
                  // Setting the center of the map
                  center: const LatLng(38.895, -77.0366),
                  // Setting the zoom level
                  zoom: 9.2,
                ),
                children: [
                  // TileLayer for the map
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  // MarkerLayer for the map
                  MarkerLayer(markers: [
                    Marker(
                        point: const LatLng(38.895, -77.0366),
                        builder: (_) {
                          // CompositedTransformTarget for the marker
                          return CompositedTransformTarget(
                              link: _link,
                              child: SizedBox(
                                  width: 50,
                                  height: 100,
                                  child: InkWell(
                                      onTap: () {
                                        print('in on tap');
                                      },
                                      onHover: (bool newValue) {
                                        print('im here');
                                        setState(() {
                                          _openDropdown = newValue;
                                        });
                                      },
                                      child: const Icon(Icons.location_on))));
                        })
                  ])
                ],
              ),
              // Text widget that is displayed when _openDropdown is true
              if (_openDropdown)
                CompositedTransformTarget(link: _link, child: const Text('hi'))
            ]))]));
  }
}

// RidePage widget which is a stateful widget
class RidePage extends StatefulWidget {
  const RidePage({super.key});

  // Creating the state for this widget
  @override
  State<RidePage> createState() => _RidePageState();
}
