import 'package:equatable/equatable.dart';

class Load extends Equatable {
  const Load({
    required this.brokerUid,
    required this.loadRef,
    required this.brokerName,
    required this.brokerPhone,
    required this.loadDate,
    required this.pickUpDate,
    required this.dropDownDate,
    required this.truckType,
    required this.price,
    required this.weigth,
    required this.description,
    required this.origin,
    required this.desitnation,
    required this.originLat,
    required this.originLng,
    required this.destinationLat,
    required this.destinationLng,
  });

  final String brokerUid;

  final String loadRef;
  final String brokerName;
  final String brokerPhone;
  final String loadDate;
  final String pickUpDate;
  final String dropDownDate;
  final String truckType;
  final int price;
  final int weigth;
  final String description;
  final String origin;
  final String desitnation;
  final double originLat;
  final double originLng;
  final double destinationLat;
  final double destinationLng;

  Map<String, dynamic> toFirestore() => {
        'broker': brokerName,
        'loadRef': loadRef,
        'brokerPhone': brokerPhone,
        'origin': origin,
        'desitnation': desitnation,
        'originLat': originLat,
        'originLng': originLng,
        'destinationLat': destinationLat,
        'destinationLng': destinationLng,
        'loadDate': loadDate,
        'pickUpDate': pickUpDate,
        'dropDownDate': dropDownDate,
        'truckType': truckType,
        'weigth': weigth,
        'price': price,
        'description': description,
        'brokerUid': brokerUid,
      };

  factory Load.fromfirestore(Map<String, dynamic> map) {
    return Load(
      brokerUid: map['brokerUid'],
      loadRef: map['loadRef'],
      brokerName: map['broker'],
      brokerPhone: map['brokerPhone'],
      origin: map['origin'],
      desitnation: map['desitnation'],
      originLat: map['originLat'],
      originLng: map['originLng'],
      destinationLat: map['destinationLat'],
      destinationLng: map['destinationLng'],
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
        brokerUid,
        loadRef,
        brokerName,
        brokerPhone,
        originLat,
        originLng,
        destinationLat,
        destinationLng,
        loadDate,
        pickUpDate,
        dropDownDate,
        truckType,
        price,
        weigth,
        description,
      ];
}
