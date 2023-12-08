import 'package:flutter/material.dart';
import 'package:mouvema/src/presentation/TransportPublic/widgets/cities.dart';

class TransportPublic extends StatefulWidget {
  @override
  _TransportPageState createState() => _TransportPageState();
}

class _TransportPageState extends State<TransportPublic> {
  String selectedCity = 'Tunis'; // Ville par défaut
  String selectedTransport = ''; // Bus ou Metro

  List<String> cities = [
    'Ariana',
    'Beja',
    'Ben Arous',
    'Bizerte',
    'Gabès',
    'Gafsa',
    'Jendouba',
    'Kairouan',
    'Kasserine',
    'Kébili',
    'Le Kef',
    'Mahdia',
    'La Manouba',
    'Médenine',
    'Monastir',
    'Nabeul',
    'Sfax',
    'Sidi Bouzid',
    'Siliana',
    'Sousse',
    'Tataouine',
    'Tozeur',
    'Tunis',
    'Zaghouan',
  ]; // Ajoutez d'autres villes au besoin

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transport public est la solution'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // DropdownButton<String>(
            //   value: selectedCity,
            //   items: cities.map((String city) {
            //     return DropdownMenuItem<String>(
            //       value: city,
            //       child: Text(city),
            //     );
            //   }).toList(),
            //   onChanged: (value) {
            //     setState(() {
            //       selectedCity = value!;
            //     });
            //   },
            // ),
            LocationButton(
              hint: 'Votre Ville',
              onLocationSelected: (val) {
                selectedCity = val;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedTransport = 'Bus';
                });
              },
              child: Text('Bus'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedTransport = 'Metro';
                });
              },
              child: Text('Métro'),
            ),
            SizedBox(height: 20),
            if (selectedTransport.isNotEmpty)
              Expanded(
                child: Card(
                  child: Center(
                    child: Text(
                      'Tableau des horaires de $selectedTransport à $selectedCity',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
