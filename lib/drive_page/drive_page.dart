// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:uber/ride_page/ride_page.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// DrivePageState class
class _DrivePageState extends State<DrivePage> {
  // Variable to store open popups
  late List<(int, int, String)> openPopups;

  // Variable for LayerLink
  late final LayerLink _link;

  // Variable to track if dropdown is open
  late bool _openDropdown;

  @override
  void initState() {
    // Initializing variables
    openPopups = [];
    _link = LayerLink();
    _openDropdown = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Getting MediaQueryData
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Center(
      child: Column(
        children: [
          SizedBox(height: 50,),
          ElevatedButton(
            onPressed: null, 
            child: Text("Ride requested at Ellipse Rd\nWheelchair, need storage")),
          SizedBox(
            width: mediaQuery.size.width,
            height: mediaQuery.size.height*.75,
            child: Stack(children: [
              FlutterMap(
                options: MapOptions(
                  center: const LatLng(38.895, -77.0366),
                  zoom: 9.2,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(markers: [
                    Marker(
                        point: const LatLng(38.895, -77.0366),
                        builder: (_) {
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
              if (_openDropdown)
                CompositedTransformTarget(link: _link, child: const Text('hi'))
            ]))]));
  }
}

// DrivePage class
class DrivePage extends StatefulWidget {
  const DrivePage({super.key});

  @override
  State<DrivePage> createState() => _DrivePageState();
}
