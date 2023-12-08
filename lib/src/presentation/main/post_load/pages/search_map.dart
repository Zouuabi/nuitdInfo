import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;
import 'package:mouvema/src/core/internet_checker.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:geocoding/geocoding.dart' as geo;
import '../widgets/searchBarMap.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, this.onchange});
  final void Function(LatLng?, LatLng?)? onchange;

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  MapController mapController = MapController();
  LatLng? _selectedLocation;
  LatLng? origin;
  LatLng? destination;
  List<Marker> markers = [];
  Map<String, Marker?> mark = {'origine': null, 'destination': null};
  bool isConnected = true;
  final TextEditingController _searchController = TextEditingController();

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
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 8,
                                spreadRadius: 2)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 35),
                      // color: Colors.white,
                      child: Column(children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.arrow_back))
                          ],
                        ),
                        TimelineTile(
                          indicatorStyle:
                              const IndicatorStyle(color: Colors.teal),
                          afterLineStyle: const LineStyle(color: Colors.teal),
                          isFirst: true,
                          endChild: ListTile(
                            title: SizedBox(
                              height: 50,
                              child: SearchBarMap(
                                location: 'origin',
                                onSearch: (value) {
                                  _searchLocation(value, 'origin', pickUpIcon);
                                },
                              ),
                            ),
                          ),
                        ),
                        TimelineTile(
                          indicatorStyle:
                              const IndicatorStyle(color: Colors.teal),
                          beforeLineStyle: const LineStyle(color: Colors.teal),
                          isLast: true,
                          endChild: ListTile(
                            title: SizedBox(
                              height: 50,
                              child: SearchBarMap(
                                  location: 'destination',
                                  onSearch: (value) {
                                    _searchLocation(
                                        value, 'destination', dropDownIcon);
                                  }),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text("ou appuiez long sur la carte"),
                      ]),
                    ))
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

  void _searchLocation(String query, String place, Icon icon) async {
    // String query = _searchController.text;
    if (query.isNotEmpty) {
      List<geo.Location> locations = await geo.locationFromAddress(query);
      if (locations.isNotEmpty) {
        setState(() {
          _selectedLocation =
              LatLng(locations[0].latitude, locations[0].longitude);
          mapController.move(_selectedLocation!, 10);
          if (place == 'origin') {
            if (origin != null) {
              markers.removeAt(0);
            }
            origin = _selectedLocation;
            markers.insert(0, marker(origin!, pickUpIcon));
          } else {
            if (destination != null) {
              markers.removeLast();
            }
            destination = _selectedLocation;
            markers.add(marker(destination!, dropDownIcon));
          }
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
        markers.insert(0, marker(point, pickUpIcon));
      });
    } else if (destination == null) {
      setState(() {
        destination = point;
        markers.insert(1, marker(point, dropDownIcon));
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

  Icon pickUpIcon = const Icon(
    Icons.location_pin,
    color: Color.fromARGB(255, 5, 206, 105),
  );
  Icon dropDownIcon = const Icon(
    Icons.location_pin,
    color: Color.fromARGB(255, 247, 23, 7),
  );
}
