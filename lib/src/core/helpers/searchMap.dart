import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, this.onchange});
  final void Function(LatLng?, LatLng?)? onchange;

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  MapController mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  LatLng? _selectedLocation;
  LatLng? origin;
  LatLng? destination;
  List<Marker> markers = [];

  void _searchLocation() async {
    String query = _searchController.text;
    if (query.isNotEmpty) {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        setState(() {
          _selectedLocation =
              LatLng(locations[0].latitude, locations[0].longitude);
          mapController.move(_selectedLocation!, 15.0);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(origin);
    print(destination);
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 300,
          height: 40,
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for a place',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: _searchLocation,
              ),
            ),
            onSubmitted: (_) => _searchLocation(),
          ),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              onLongPress: (tapPosition, point) {
                if (origin != null &&
                    _isSameLocation(point, origin!, mapController.zoom)) {
                  setState(() {
                    markers.removeAt(0);
                    origin = null;
                  });
                } else if (destination != null &&
                    _isSameLocation(point, destination!, mapController.zoom)) {
                  setState(() {
                    markers.removeLast();
                    destination = null;
                  });
                } else if (origin == null) {
                  setState(() {
                    origin = point;
                    markers.insert(
                        0,
                        marker(
                            point,
                            const Icon(
                              Icons.arrow_circle_up_outlined,
                              color: Color.fromARGB(255, 5, 206, 105),
                            )));
                  });
                } else if (destination == null) {
                  setState(() {
                    destination = point;
                    markers.insert(
                        1,
                        marker(
                            point,
                            const Icon(
                              Icons.arrow_circle_up_outlined,
                              color: Color.fromARGB(255, 206, 31, 5),
                            )));
                    widget.onchange!(origin, destination);
                  });
                }
              },
              center: _selectedLocation ??
                  const LatLng(
                      40.7128, -74.0060), // Default: New York City coordinates
              zoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(markers: markers

                  // [
                  //   (_selectedLocation != null)
                  //       ? Marker(
                  //           point: _selectedLocation!,
                  //           builder: (ctx) => const Icon(
                  //             Icons.location_pin,
                  //             color: Colors.red,
                  //             size: 40.0,
                  //           ),
                  //         )
                  //       : Marker(
                  //           point: const LatLng(0, 0),
                  //           builder: (context) => const Icon(Icons.abc),
                  //         )
                  // ]

                  )
            ],
          ),
        ],
      ),
    );
  }

  Marker marker(LatLng point, Icon markerIcon) {
    return Marker(
      point: LatLng(point.latitude, point.longitude),
      builder: (context) {
        return markerIcon;
      },
    );
  }

  double _calculateDistance(LatLng latLng1, LatLng latLng2) {
    const double earthRadius = 6371.0;

    double lat1 = latLng1.latitude;
    double lon1 = latLng1.longitude;
    double lat2 = latLng2.latitude;
    double lon2 = latLng2.longitude;

    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;
    return distance;
  }

  double _toRadians(double degrees) {
    return degrees * (pi / 180.0);
  }

  bool _isSameLocation(LatLng location1, LatLng location2, double zoom) {
    double markerTolerance;
    if (zoom < 10) {
      markerTolerance = 0.1;
    } else {
      markerTolerance = 0.01;
    }

    return (location1.latitude - location2.latitude).abs() < markerTolerance &&
        (location1.longitude - location2.longitude).abs() < markerTolerance;
  }
}
