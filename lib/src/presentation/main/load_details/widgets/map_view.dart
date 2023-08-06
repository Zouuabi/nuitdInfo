import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';

class MapView extends StatelessWidget {
  const MapView({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      width: double.infinity,
      height: size.height * 0.3,
      child: FlutterMap(
        options: MapOptions(
          center: const LatLng(1.509364, 1.128928),
          zoom: 2,
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
        ],
      ),
    );
  }
}
