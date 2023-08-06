import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';

class MapView extends StatelessWidget {
  const MapView({
    super.key,
    required this.size,
  });
  final LatLng origin = const LatLng(34.8333, 9.7833);
  final LatLng destination = const LatLng(34.8333, 10.7833);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: size.height * 0.4,
          child: FlutterMap(
            options: MapOptions(
              center: LatLng((origin.latitude + destination.latitude) / 2,
                  (origin.longitude + destination.longitude) / 2),
              zoom: 7,
            ),
            // nonRotatedChildren: [
            //   RichAttributionWidget(
            //     attributions: [
            //       TextSourceAttribution(
            //         'OpenStreetMap contributors',
            //         onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
            //       ),
            //     ],
            //   ),
            // ],
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
                      color: Colors.green,
                    );
                  },
                ),
                Marker(
                  point: destination,
                  builder: (context) {
                    return const Icon(
                      Icons.arrow_circle_down_outlined,
                      color: Colors.red,
                    );
                  },
                ),
              ])
            ],
          ),
        ),
        Positioned(
            bottom: 10,
            left: size.width * 0.4,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.teal, borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(8),
              child: Text(
                '${calculateDistance(origin, destination).toString().substring(0, 4)} km',
                style:
                    const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ))
      ],
    );
  }
}

double calculateDistance(LatLng latLng1, LatLng latLng2) {
  const double earthRadius = 6371.0; // Radius of the Earth in kilometers

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
