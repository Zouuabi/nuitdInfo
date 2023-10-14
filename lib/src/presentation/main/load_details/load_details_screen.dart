import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/models/load.dart';
import '../../shared/toggle_farvorite_button.dart';
import 'widgets/details.dart';
import 'widgets/map_view.dart';

class LoadDetailsScreen extends StatelessWidget {
  const LoadDetailsScreen({
    super.key,
    required this.load,
  });

  final Load load;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: const Text('Details'),
        actions: [ToggleFavorites(loadRef: load.loadRef)],
        centerTitle: true,
      ),

      //appBar: _getAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // *** kharita
            MapView(
                origin: LatLng(load.originLat, load.originLng),
                destination: LatLng(load.destinationLat, load.destinationLng),
                size: size),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Details(
                load: load,
              ),
            )
          ],
        ),
      ),
    );
  }
}
