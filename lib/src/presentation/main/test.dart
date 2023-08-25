import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mouvema/src/presentation/main/test_cubit.dart';

import '../../injector.dart';

// A function that takes a query and returns a list of places
Future<List<Place>> searchPlaces(String query) async {
  // The base URL of the Nominatim API
  const String baseUrl = 'nominatim.openstreetmap.org';

  // The parameters for the API request
  final Map<String, String> params = {
    'q': query, // The query to search for
    'format': 'json', // The format of the response
    'limit': '10', // The maximum number of results
    'addressdetails': '1', // Include address details in the response
  };

  // The full URL with the parameters
  final Uri url = Uri.https(
    baseUrl,
    '/search',
    params,
  );

  // Send a GET request to the URL and wait for the response
  final http.Response response = await http.get(url);

  // Parse the response as a list of JSON objects
  final List<dynamic> data = jsonDecode(response.body);

  // Convert each JSON object to a Place object and return the list
  return data.map((json) => Place.fromJson(json)).toList();
}

// A class that represents a place with its name, address, and coordinates
class Place {
  final String name;
  final String address;
  final LatLng coordinates;

  Place(this.name, this.address, this.coordinates);

  // A factory constructor that creates a Place from a JSON object
  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      json['display_name'], // The name of the place
      json['address']['road'] ?? '', // The road name of the address
      LatLng(
        // The coordinates of the place
        double.parse(json['lat']),
        double.parse(json['lon']),
      ),
    );
  }
}

// A class that represents a search delegate for places
class PlaceSearchDelegate extends SearchDelegate<Place> {
  // A reference to the map controller
  final MapController mapController;

  PlaceSearchDelegate(this.mapController);

  // A method that builds the suggestions based on the query
  @override
  Widget buildSuggestions(BuildContext context) {
    // If the query is empty, show a placeholder text
    if (query.isEmpty) {
      return const Center(
        child: Text('Enter a place to search'),
      );
    }

    // Otherwise, show a list of places that match the query
    return BlocProvider(
      create: (context) => TestCubit(),
      child: FutureBuilder<List<Place>>(
        future: searchPlaces(
            query), // Call the searchPlaces function with the query
        builder: (context, snapshot) {
          // If the snapshot has data, show the list of places
          if (snapshot.hasData) {
            final List<Place>? places = snapshot.data;

            return ListView.builder(
              itemCount: places!.length,
              itemBuilder: (context, index) {
                final Place place = places[index];

                return ListTile(
                  title: Text(place.name), // Show the name of the place
                  subtitle:
                      Text(place.address), // Show the address of the place
                  onTap: () {
                    close(context, place);
                  },
                );
              },
            );
          }

          // If the snapshot has an error, show an error message
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          // Otherwise, show a progress indicator
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  // A method that builds the results based on the selection
  @override
  Widget buildResults(BuildContext context) {
    return Container();
    // if (selection == null) {
    //   return Container();
    // }

    // // Otherwise, move the map to the coordinates of the selected place
    // mapController.move(selection!.coordinates, 15);

    // // And show a text with the name of the selected place
    // return Center(
    //   child: Text('You selected: ${selection!.name}'),
    // );
  }

  // A method that builds the actions for the app bar
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      // A button that clears the query
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Text('Lawej ');
  }
}

// A widget that shows a map with a search bar
class MapWithSearchBar extends StatefulWidget {
  const MapWithSearchBar({super.key});

  @override
  State<MapWithSearchBar> createState() => _MapWithSearchBarState();
}

class _MapWithSearchBarState extends State<MapWithSearchBar> {
  // A controller for the map
  final MapController mapController = MapController();

  LatLng a = LatLng(34, 11);
  double zoom = 7;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => instance<TestCubit>(),
      child: Scaffold(
        body: BlocConsumer<TestCubit, TestState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Stack(
              children: [
                FlutterMap(
                  mapController:
                      mapController, // Assign the map controller to the FlutterMap widget
                  options: MapOptions(
                      center: a, // The initial center of the map
                      zoom: zoom // The initial zoom level of the map
                      ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', // The URL template of the tile provider
                      subdomains: const [
                        'a',
                        'b',
                        'c'
                      ], // The subdomains of the tile provider
                    ),
                  ],
                ),
                Center(
                  child: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () async {
                        var r = await showSearch<Place>(
                            context: context,
                            delegate: PlaceSearchDelegate(mapController));

                        setState(() {
                          a = r!.coordinates;
                          zoom = 15;
                        });
                      }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
