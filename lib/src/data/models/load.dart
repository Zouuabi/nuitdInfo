import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Load extends Equatable {
  const Load(
      {required this.loadRef,
      required this.brokerName,
      required this.brokerPhone,
      required this.origin,
      required this.destination,
      required this.originPoint,
      required this.desitinationPoint,
      required this.loadDate,
      required this.pickUpDate,
      required this.dropDownDate,
      required this.truckType,
      required this.price,
      required this.weigth,
      required this.description});

  final String loadRef;
  final String brokerName;
  final String brokerPhone;
  final String origin;
  final String destination;
  final String loadDate;
  final String pickUpDate;
  final String dropDownDate;
  final String truckType;
  final int price;
  final int weigth;
  final String description;
  final GeoPoint? originPoint;
  final GeoPoint? desitinationPoint;

  Map<String, dynamic> toFirestore() => {
        'broker': loadRef,
        'loadRef': brokerName,
        'brokerPhone': brokerPhone,
        'origin': origin,
        ' originPoint': originPoint,
        'destination': destination,
        'desitinationPoint': desitinationPoint,
        'loadDate': loadDate,
        'pickUpDate': pickUpDate,
        'dropDownDate': dropDownDate,
        'truckType': truckType,
        'weigth': weigth,
        'price': price,
        'description': description,
      };

  factory Load.fromfirestore(Map<String, dynamic> map) {
    return Load(
      loadRef: map['loadRef'],
      brokerName: map['broker'],
      brokerPhone: map['brokerPhone'],
      origin: map['origin'],
      originPoint: map['originPoint'],
      desitinationPoint: map['desitination'],
      destination: map['destination'],
      loadDate: map['loadDate'],
      pickUpDate: map['pickUpDate'],
      dropDownDate: map['dropDownDate'],
      truckType: map['truckType'],
      weigth: map['weigth'],
      price: map['price'],
      description: map['description'],
    );
  }

  @override
  List<Object?> get props => [
        loadRef,
        brokerName,
        brokerPhone,
        origin,
        destination,
        loadDate,
        pickUpDate,
        dropDownDate,
        truckType,
        price,
        weigth,
        description,
      ];
}
