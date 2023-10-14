import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mouvema/src/core/helpers/date_handler.dart';

import '../../../../data/models/load.dart';

class LoadItem extends StatelessWidget {
  const LoadItem({super.key, required this.load, required this.detailsButton});
  final Load load;
  final VoidCallback detailsButton;

  @override
  Widget build(BuildContext context) {
    Duration age = DateHandler.diffBetween2Dates(
        start: DateHandler.convertStringToDate(date: load.loadDate),
        end: DateHandler.convertStringToDate(
            date: DateTime.now().toString().substring(0, 10)));

    return GestureDetector(
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(children: [
            // ***** little banner ******
            Row(
              children: [
                Text('age: ${DateHandler.handleAge(age)}'),
                const Spacer(),
                Text(
                  DateHandler.formatDate(load.loadDate.toString()),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/images/${load.truckType}.svg',
                  width: 50,
                  height: 50,
                  // ignore: deprecated_member_use
                  color: Colors.white60,
                ),
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
                  //load.origin.toUpperCase(),
                  'morzeg',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Text(DateHandler.formatDate(load.pickUpDate))
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
                  // load.destination.toUpperCase(),
                  'Morzeg',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Text(DateHandler.formatDate(load.dropDownDate))
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
