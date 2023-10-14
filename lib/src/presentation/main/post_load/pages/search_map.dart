import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart' as loc;
import 'package:mouvema/src/core/internet_checker.dart';
import 'package:mouvema/src/data/data_source/remote_data_source/geocoding.dart';

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
  bool isConnected = true;

  void _searchLocation() async {
    String query = _searchController.text;
    if (query.isNotEmpty) {
      List<geo.Location> locations = await geo.locationFromAddress(query);
      if (locations.isNotEmpty) {
        setState(() {
          _selectedLocation =
              LatLng(locations[0].latitude, locations[0].longitude);
          mapController.move(_selectedLocation!, 15.0);
        });
      }
    }
  }

  void verifyConnection() async {
    bool a = await InternetCheckerImpl().isConnected();

    setState(() {
      isConnected = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    verifyConnection();
    return (isConnected)
        ? Scaffold(
            floatingActionButton: IconButton(
                onPressed: () async {
                  _getCurrentLocation(mapController);
                },
                icon: Image.asset(
                  'assets/images/direction.png',
                  width: 50,
                )),
            body: Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    onLongPress: (tapPosition, point) {
                      onLongPress(tapPosition, point);
                    },
                    center: _selectedLocation ?? const LatLng(34, 11),
                    zoom: 6,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(markers: markers)
                  ],
                ),
                Positioned(
                  top: 50,
                  left: MediaQuery.of(context).size.width * 0.05,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
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
                // Positioned(
                //   top: 600,
                //   bottom: 300,
                //   left: 60,
                //   right: 60,
                //   child: SizedBox(
                //     height: 50,
                //     width: 50,
                //     child: ElevatedButton(
                //         onPressed: () async {
                //           print(
                //               await PositionGeocoding.reverseGeocode(origin!));
                //         },
                //         child: Text('Test')),
                //   ),
                // )
              ],
            ))
        : Scaffold(
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(
                  'assets/images/warning.png',
                  width: 50,
                )),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text('There is no internet connection'),
                ),
              ],
            ),
          );
  }

  void onLongPress(tapPosition, point) {
    if (origin != null && _isSameLocation(point, origin!, mapController.zoom)) {
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
  }

  Marker marker(LatLng point, Icon markerIcon) {
    return Marker(
      point: LatLng(point.latitude, point.longitude),
      builder: (context) {
        return markerIcon;
      },
    );
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

  Future<void> _getCurrentLocation(MapController mapController) async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
    loc.Location location = loc.Location();

    // Check if location services are enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Check for location permissions
    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }
    loc.LocationData locationData = await location.getLocation();
    mapController.move(
        LatLng(locationData.latitude!, locationData.longitude!), 8);

    onLongPress(null, LatLng(locationData.latitude!, locationData.longitude!));
  }
}
