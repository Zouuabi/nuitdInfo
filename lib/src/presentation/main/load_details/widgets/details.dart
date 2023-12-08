import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mouvema/src/core/utils/string_manager.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/helpers/date_handler.dart';
import '../../../../data/models/load.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.load});

  final Load load;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateHandler.formatDate(widget.load.loadDate.toString()),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text('Ref#${widget.load.loadRef.substring(0, 6)}',
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
        const Divider(),
        Row(
          children: [
            Expanded(
              child: PickAndDrop(
                origin: widget.load.origin,
                destination: widget.load.desitnation,
                pickUpDate: widget.load.pickUpDate,
              ),
            ),
            Expanded(
              child: ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.teal,
                  size: 30,
                ),
                title: Text(
                  StringManager.driver,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text('${widget.load.brokerName} ',
                    style: Theme.of(context).textTheme.bodyMedium),
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
              Text('détails', style: Theme.of(context).textTheme.headlineSmall),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                        title: const Text('Poids Disponible'),
                        subtitle: Text('${widget.load.weigth} Kg'),
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
                      title: const Text('Camion'),
                      subtitle: Text(widget.load.truckType),
                      leading: SvgPicture.asset(
                        'assets/images/${widget.load.truckType}.svg',
                        width: 40,
                        height: 45,
                        // ignore: deprecated_member_use
                      ),
                    ),
                  ),
                ],
              ),
              ListTile(
                title: const Text('Description'),
                subtitle: Text(widget.load.description),
              ),
              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: FilledButton(
                      onPressed: () {
                        callNumber(widget.load.brokerPhone);
                      },
                      child: const Text('Appeler le conducteur')))
            ],
          ),
        ),
      ],
    );
  }
}

callNumber(String phoneNumber) async {
  var tel = Uri.parse('tel:+216$phoneNumber');
  if (await canLaunchUrl(tel)) {
    await launchUrl(tel);
  } else {
    throw 'Could not launch $phoneNumber';
  }
}

class PickAndDrop extends StatelessWidget {
  const PickAndDrop(
      {super.key,
      required this.pickUpDate,
      required this.origin,
      required this.destination});

  final String pickUpDate;

  final String origin;
  final String destination;

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
              style: Theme.of(context).textTheme.titleSmall,
            ),
            subtitle: Text(DateHandler.formatDate(pickUpDate),
                style: Theme.of(context).textTheme.bodyMedium),
          ),
        ),
        TimelineTile(
          indicatorStyle: const IndicatorStyle(color: Colors.teal),
          beforeLineStyle: const LineStyle(color: Colors.teal),
          isLast: true,
          endChild: ListTile(
            title: Text(
              destination,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
      ],
    );
  }
}
