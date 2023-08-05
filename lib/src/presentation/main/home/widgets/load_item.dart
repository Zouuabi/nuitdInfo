import 'package:flutter/material.dart';

import '../../../../data/models/load.dart';

class LoadItem extends StatelessWidget {
  const LoadItem({super.key, required this.load, required this.detailsButton});
  final Load load;
  final VoidCallback detailsButton;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(children: [
            // ***** little banner ******
            Row(
              children: [
                const Text('age:'),
                const Spacer(),
                Text(
                  load.loadDate,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Text(load.truckType)
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Icon(
                  Icons.arrow_circle_up,
                  size: 35,
                  color: Colors.green,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  load.origin.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Text(load.pickUpDate)
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Icon(
                  Icons.arrow_circle_down,
                  size: 35,
                  color: Colors.red,
                ),
                const SizedBox(width: 15),
                Text(
                  load.destination.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Text(load.dropDownDate)
              ],
            ),
            const Divider(),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      'Broker :',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      load.brokerName,
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: detailsButton,
                  child: const Text(
                    'View Details',
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
