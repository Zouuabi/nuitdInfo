import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Load {
  const Load(
      {required this.loadDate,
      required this.pickUpDate,
      required this.dropDownDate,
      required this.truckType,
      required this.brokerName,
      required this.brokerTel,
      required this.origin,
      required this.destination,
      this.loadRef = '',
      required this.price,
      required this.description,
      required this.weigth,
      required this.originPoint,
      required this.desitinationPoint});

  final String loadDate;
  final String pickUpDate;
  final String dropDownDate;
  final String truckType;
  final String brokerName;
  final String brokerTel;
  final String origin;
  final String destination;
  final String loadRef;
  final String price;
  final String description;
  final String weigth;
  final GeoPoint originPoint;
  final GeoPoint desitinationPoint;

  Map<String, dynamic> toFirestore() => {
        'loadRef': loadRef,
        'origin': origin,
        'destination': destination,
        'loadDate': loadDate,
        'pickUpdate': pickUpDate,
        'brokerTel': brokerTel,
        'price': price,
        'weigth': weigth,
        'dropDownDate': dropDownDate,
        'description': description,
        'brokerName': brokerName,
        'truckType': truckType,
      };

  factory Load.fromfirestore(Map<String, dynamic> map) {
    return Load(
        brokerName: map['broker'],
        brokerTel: map['telbroker'],
        description: map['description'],
        destination: map['destination'],
        dropDownDate: map['dropdowndate'],
        loadDate: map['loaddate'],
        origin: map['origin'],
        pickUpDate: map['pickupdate'],
        price: map['price'],
        truckType: map['trucktype'],
        weigth: map['weigth'],
        loadRef: map['loadRef'],
        originPoint: map['originPoint'],
        desitinationPoint: map['destinationPoint']);
  }
}
