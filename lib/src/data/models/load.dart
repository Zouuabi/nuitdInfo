class Load {
  const Load({
    required this.loadDate,
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
  });

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
        'truckType': truckType
      };
}
