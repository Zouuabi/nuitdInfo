import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../core/helpers/date_handler.dart';
import '../../data/models/load.dart';

class LoadItem extends StatefulWidget {
  LoadItem({
    super.key,
    required this.load,
    required this.detailsButton,
    this.longPressed,
  });
  final Load load;
  final VoidCallback detailsButton;
  void Function()? longPressed;

  @override
  State<LoadItem> createState() => _LoadItemState();
}

class _LoadItemState extends State<LoadItem> {
  bool ispressed = false;
  @override
  Widget build(BuildContext context) {
    Duration age = DateHandler.diffBetween2Dates(
        start: DateHandler.convertStringToDate(date: widget.load.loadDate),
        end: DateHandler.convertStringToDate(
            date: DateTime.now().toString().substring(0, 10)));

    return GestureDetector(
      onLongPress: () {
        ispressed = !ispressed;
        widget.longPressed!();
      },
      child: Card(
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 198, 234, 230),
              borderRadius: BorderRadius.circular(13),
              border:
                  ispressed ? Border.all(color: Colors.teal, width: 2) : null),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(children: [
            // ***** little banner ******
            Row(
              children: [
                Text('age: ${DateHandler.handleAge(age)}'),
                const Spacer(),
                Text(
                  DateHandler.formatDate(widget.load.loadDate.toString()),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/images/${widget.load.truckType}.svg',
                  width: 50,
                  height: 50,
                  // ignore: deprecated_member_use
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Icon(
                  Icons.arrow_circle_up,
                  size: 25,
                  color: Colors.green,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  widget.load.origin.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Text(DateHandler.formatDate(widget.load.pickUpDate))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Icon(
                  Icons.arrow_circle_down,
                  size: 25,
                  color: Colors.red,
                ),
                const SizedBox(width: 15),
                Text(
                  widget.load.destination.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Text(DateHandler.formatDate(widget.load.dropDownDate))
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
                      widget.load.brokerName,
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 100,
                  height: 30,
                  child: FilledButton(
                    onPressed: widget.detailsButton,
                    child: const Text(
                      'View Details',
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
