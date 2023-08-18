import 'package:doft/src/core/helpers/date_handler.dart';
import 'package:doft/src/core/utils/color_manager.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/load.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeline_tile/timeline_tile.dart';

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
            Text(
              DateHandler.formatDate(load.loadDate.toString()),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text('Ref#${load.loadRef.substring(0, 6)}',
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
        const Divider(),
        Row(
          children: [
            Expanded(
              child: PickAndDrop(
                  origin: load.origin,
                  destination: load.destination,
                  pickUpDate: load.pickUpDate,
                  dropDownDate: load.dropDownDate),
            ),
            Expanded(
              child: ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.teal,
                  size: 50,
                ),
                title: Text(
                  'Broker',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text('${load.brokerName} LLC'),
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              Text('Details',
                  style: Theme.of(context).textTheme.headlineMedium),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                        title: const Text('Price  '),
                        subtitle: Text('${load.price} TND'),
                        // trailing: Text('${load.weigth} KG '),
                        leading: const Icon(
                          Icons.attach_money,
                          size: 40,
                        )),
                  ),
                  Expanded(
                    child: ListTile(
                        title: const Text('Weight'),
                        subtitle: Text('${load.weigth} Kg'),
                        // trailing: Text('${load.weigth} KG '),
                        leading: const Icon(
                          Icons.balance_outlined,
                          size: 40,
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Truck'),
                      subtitle: Text(load.truckType),
                      // trailing: Text('${load.weigth} KG '),
                      leading: SvgPicture.asset(
                        'assets/images/${load.truckType}.svg',
                        width: 40,
                        height: 45,
                        // ignore: deprecated_member_use
                      ),
                    ),
                  ),
                  const Expanded(
                    child: ListTile(
                      title: const Text('Commodity'),
                      subtitle: const Text('Fresh food'),
                      // trailing: Text('${load.weigth} KG '),
                      leading: Icon(
                        Icons.file_copy_outlined,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              ListTile(
                title: const Text('Description'),
                subtitle: Text(load.description),
              ),
              SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: FilledButton(
                      onPressed: () {}, child: const Text('Call Broker')))
            ],
          ),
        ),
      ],
    );
  }
}

class PickAndDrop extends StatelessWidget {
  const PickAndDrop(
      {super.key,
      required this.origin,
      required this.destination,
      required this.pickUpDate,
      required this.dropDownDate});

  final String origin;
  final String destination;
  final String pickUpDate;
  final String dropDownDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimelineTile(
          indicatorStyle: const IndicatorStyle(color: Colors.teal),
          afterLineStyle: const LineStyle(color: Colors.teal),
          isFirst: true,
          endChild: ListTile(
            title: Text(
              origin,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(DateHandler.formatDate(pickUpDate),
                style: Theme.of(context).textTheme.bodyLarge),
          ),
        ),
        TimelineTile(
          indicatorStyle: const IndicatorStyle(color: Colors.teal),
          beforeLineStyle: const LineStyle(color: Colors.teal),
          isLast: true,
          endChild: ListTile(
            title: Text(
              destination,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              DateHandler.formatDate(dropDownDate),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }
}
