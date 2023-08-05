import 'package:flutter/material.dart';

import '../../../../data/models/load.dart';

class Details extends StatelessWidget {
  const Details({super.key, required this.load});

  final Load load;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(load.loadDate, style: const TextStyle(fontSize: 20)),
            const Text('Ref#1582651'),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              //*******  time to pick upp *********
              ListTile(
                leading: const Icon(
                  Icons.arrow_circle_up,
                  color: Colors.green,
                  size: 50,
                ),
                title: Text(
                  load.origin,
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: Text('Pick up ${load.pickUpDate}'),
              ),
              //*******  time to drop down *********
              ListTile(
                leading: const Icon(
                  Icons.arrow_circle_down,
                  color: Colors.red,
                  size: 50,
                ),
                title: Text(
                  load.destination,
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: Text('Drop ${load.dropDownDate}'),
              ),
              Divider(color: Colors.teal.shade100),
              ListTile(
                title: const Text('Price  '),
                subtitle: Text('${load.price} TND'),
                trailing: Text('${load.weigth} KG '),
                leading: const Icon(
                  Icons.fire_truck,
                  size: 50,
                ),
              ),

              Divider(color: Colors.teal.shade100),
              ListTile(
                leading: const Icon(
                  Icons.person,
                  size: 40,
                ),
                title: const Text('Broker'),
                subtitle: Text('${load.brokerName} LLC'),
              ),
              ListTile(
                title: const Text('Description'),
                subtitle: Text(load.description),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
