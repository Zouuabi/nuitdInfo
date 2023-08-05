import 'package:flutter/material.dart';

List<Map<String, String>> loads = [
  {
    'loaddate': '6/12',
    'pickupdate': '20/6',
    'dropdowndate': '25/6',
    'trucktype': 'poid lourd',
    'broker': 'taher ',
    'telbroker': '97 285 362',
    'origin': 'nabeul',
    'destination': 'gbeli'
  },
  {
    'loaddate': '16/26',
    'pickupdate': '56/6',
    'dropdowndate': '26/15',
    'trucktype': 'stafett',
    'broker': 'hedi',
    'telbroker': '23654159',
    'origin': 'nabeul',
    'destination': 'gbeli'
  },
  {
    'loaddate': '12/06',
    'pickupdate': '12/5',
    'dropdowndate': '12/6',
    'trucktype': 'pick up',
    'broker': 'anis',
    'telbroker': '56235956',
    'origin': 'nabeul',
    'destination': 'gbeli'
  },
];

class Load {
  const Load(
      {required this.loadDate,
      required this.pickUpDate,
      required this.dropDownDate,
      required this.truckType,
      required this.brokerName,
      required this.brokerTel,
      required this.origin,
      required this.destination});

  final String loadDate;
  final String pickUpDate;
  final String dropDownDate;
  final String truckType;
  final String brokerName;
  final String brokerTel;
  final String origin;
  final String destination;
}
