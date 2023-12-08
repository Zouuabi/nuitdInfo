import 'package:flutter/material.dart';
import 'package:mouvema/src/presentation/TransportPublic/pages/TransportPublic.dart';

final List<BusSchedule> metroSchedules = [
  BusSchedule(
    date: DateTime(2023, 12, 1),
    busDetails: [
      BusDetails(
        busNumber: 'Metro 1',
        departure: 'Station A',
        arrival: 'Station B',
        time: TimeOfDay(hour: 8, minute: 0),
      ),
      BusDetails(
        busNumber: 'Metro 2',
        departure: 'Station C',
        arrival: 'Station D',
        time: TimeOfDay(hour: 9, minute: 30),
      ),
    ],
  ),
  BusSchedule(
    date: DateTime(2023, 12, 15),
    busDetails: [
      BusDetails(
        busNumber: 'Metro 3',
        departure: 'Station X',
        arrival: 'Station Y',
        time: TimeOfDay(hour: 11, minute: 0),
      ),
      BusDetails(
        busNumber: 'Metro 4',
        departure: 'Station P',
        arrival: 'Station Q',
        time: TimeOfDay(hour: 13, minute: 45),
      ),
    ],
  ),
  // Ajoutez d'autres données d'horaire de bus selon vos besoins
];

final List<BusSchedule> busSchedules = [
  BusSchedule(
    date: DateTime(2023, 12, 1),
    busDetails: [
      BusDetails(
        busNumber: 'Bus A',
        departure: 'Gare F',
        arrival: 'Gare G',
        time: TimeOfDay(hour: 8, minute: 0),
      ),
      BusDetails(
        busNumber: 'Bus B',
        departure: 'Gare K',
        arrival: 'Gare R',
        time: TimeOfDay(hour: 9, minute: 30),
      ),
    ],
  ),
  BusSchedule(
    date: DateTime(2023, 12, 15),
    busDetails: [
      BusDetails(
        busNumber: 'Bus C',
        departure: 'Gare T',
        arrival: 'Gare s',
        time: TimeOfDay(hour: 11, minute: 0),
      ),
      BusDetails(
        busNumber: 'Bus D',
        departure: 'Gare N',
        arrival: 'Gare J',
        time: TimeOfDay(hour: 13, minute: 45),
      ),
    ],
  ),
  // Ajoutez d'autres données d'horaire de bus selon vos besoins
];
