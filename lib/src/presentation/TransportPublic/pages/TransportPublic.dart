import 'package:flutter/material.dart';
import 'package:mouvema/src/presentation/TransportPublic/widgets/ShedulesData.dart';
import 'package:mouvema/src/presentation/TransportPublic/widgets/cities.dart';
import 'package:table_calendar/table_calendar.dart';

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
        title: const Text('Transport publique est la solution'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
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
          if (selectedTransport == "Bus")
            BusScheduleScreen(
              selectedTransport: selectedTransport,
              TransportSchedules: busSchedules,
              selectedCity: selectedCity,
            )
          else if (selectedTransport == "Metro")
            Expanded(
              child: BusScheduleScreen(
                selectedTransport: selectedTransport,
                TransportSchedules: busSchedules,
                selectedCity: selectedCity,
              ),
            )
          else
            Container(
              width: double.infinity - 20,
              height: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 182, 230, 225)),
              child: const Center(
                  child: Text(
                "Choisir la ville et la moyen de Transport publique et voir les horaires",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              )),
            )
        ],
      ),
    );
  }
}

class BusSchedule {
  final DateTime date;
  final List<BusDetails> busDetails;

  BusSchedule({
    required this.date,
    required this.busDetails,
  });
}

class BusDetails {
  final String busNumber;
  final String departure;
  final String arrival;
  final TimeOfDay time;

  BusDetails({
    required this.busNumber,
    required this.departure,
    required this.arrival,
    required this.time,
  });
}

class BusScheduleScreen extends StatelessWidget {
  BusScheduleScreen({
    super.key,
    required this.selectedTransport,
    required this.TransportSchedules,
    required this.selectedCity,
  });
  final String selectedTransport;
  final List<BusSchedule> TransportSchedules;
  final String selectedCity;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Les Horaires de $selectedTransport en $selectedCity ",
          style: TextStyle(fontSize: 19),
        ),
        Container(
          height: 430,
          child: ListView.builder(
            itemCount: busSchedules.length,
            itemBuilder: (context, index) {
              final busSchedule = busSchedules[index];
              return Card(
                child: ListTile(
                  title: Text(
                      'Calendrier de  ${busSchedule.date.day}/${busSchedule.date.month}/${busSchedule.date.year}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: busSchedule.busDetails.map((busDetails) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${selectedTransport}: ${busDetails.busNumber}'),
                            Text('Départ: ${busDetails.departure}'),
                            Text('Arrivée: ${busDetails.arrival}'),
                            Text(
                                'Heure: ${busDetails.time.hour}:${busDetails.time.minute}'),
                            Divider(),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
