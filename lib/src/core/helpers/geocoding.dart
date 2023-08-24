import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong2/latlong.dart';

const String _apiKey = 'pk.69a5e0f7ff40ba456a4fea6850462dab';

class Geocodingg {
  static Future<String> reverseGeocode(LatLng point) async {
    final String osmUrl =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${point.latitude}&lon=${point.longitude}';

    try {
      final response = await http.get(Uri.parse(osmUrl));

      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);
        String address = decodedJson['display_name'];
        return address;
      } else {
        return 'Error';
      }
    } catch (e) {
      return 'Error';
    }
  }

  static Future<LatLng> geocode(String locationName) async {
    final String encodedLocation = Uri.encodeComponent(locationName);
    final String osmUrl =
        'https://nominatim.openstreetmap.org/search?q=$encodedLocation&format=json-language=en-US';

    try {
      final response = await http.get(Uri.parse(osmUrl));
      print(response.body);

      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);
        if (decodedJson.isNotEmpty) {
          double latitude = double.parse(decodedJson[0]['lat']);
          double longitude = double.parse(decodedJson[0]['lon']);
          return LatLng(latitude, longitude);
        } else {
          return const LatLng(
              0, 0); // Default coordinates if location not found
        }
      } else {
        return const LatLng(0, 0); // Default coordinates on error
      }
    } catch (e) {
      return const LatLng(0, 0); // Default coordinates on exception
    }
  }
}
