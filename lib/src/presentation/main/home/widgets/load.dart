import 'package:flutter/material.dart';

import '../../../../core/dummy_data.dart';

class LoadItem extends StatelessWidget {
  const LoadItem({super.key, required this.load});
  final Load load;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Row(
              children: [
                Text(load.loadDate),
                const Spacer(),
                Text(load.loadDate),
                const Spacer(),
                Text(load.truckType)
              ],
            ),
            Divider(color: Colors.teal.shade100),
            Row(
              children: [
                Icon(Icons.arrow_circle_up),
                SizedBox(
                  width: 10,
                ),
                Text(load.origin),
                Spacer(),
                Text(load.pickUpDate)
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Icon(Icons.arrow_circle_down),
                SizedBox(
                  width: 10,
                ),
                Text(load.destination),
                Spacer(),
                Text(load.dropDownDate)
              ],
            ),
            Divider(color: Colors.teal.shade100),
            Row(
              children: [
                Column(
                  children: [Text('Broker :'), Text(load.brokerName)],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.teal)),
                  child: const Text('Call'),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
