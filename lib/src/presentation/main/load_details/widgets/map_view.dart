// ignore_for_file: depend_on_referenced_packages

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'
    show
        FlutterMap,
        InteractiveFlag,
        MapController,
        MapOptions,
        Marker,
        MarkerLayer,
        TileLayer;

import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class MapView extends StatelessWidget {
  MapView({
    super.key,
    required this.size,
    required this.origin,
    required this.destination,
  });
  final LatLng origin;
  final LatLng destination;
  final Size size;
  late List<Marker> markers;

  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.teal, width: 2)),
          width: double.infinity,
          height: size.height * 0.4,
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              interactiveFlags: InteractiveFlag.none,
              center: calculateCenter(origin, destination),
              zoom: 6,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(markers: [
                Marker(
                  point: origin,
                  builder: (context) {
                    return const Icon(
                      Icons.arrow_circle_up_outlined,
                      color: Color.fromARGB(255, 8, 240, 8),
                    );
                  },
                ),
                Marker(
                  point: destination,
                  builder: (context) {
                    return const Icon(
                      Icons.arrow_circle_down_outlined,
                      color: Color.fromARGB(255, 240, 12, 12),
                    );
                  },
                ),
              ])
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.teal, borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(8),
              child: Text(
                '${_calculateDistance(LatLng(origin.latitude, origin.longitude), LatLng(destination.latitude, destination.longitude)).toString().substring(0, 4)} km',
                style:
                    const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              )),
        ),
        Positioned(
            bottom: 7,
            right: 7,
            child: IconButton(
              onPressed: () {
                openGoogleMapsDirections(origin, destination);
              },
              icon: Image.asset(
                'assets/images/right-arrow.png',
                width: 40,
              ),
            ))
      ],
    );
  }

  LatLng calculateCenter(LatLng point1, LatLng point2) {
    double avgLatitude = (point1.latitude + point2.latitude) / 2;
    double avgLongitude = (point1.longitude + point2.longitude) / 2;
    return LatLng(avgLatitude, avgLongitude);
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

void openGoogleMapsDirections(LatLng origin, LatLng destination) async {
  final url =
      'https://www.google.com/maps/dir/?api=1&origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&travelmode=driving';

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch Google Maps';
  }
}
