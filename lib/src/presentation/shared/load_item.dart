import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:mouvema/src/core/utils/color_manager.dart';
import 'package:mouvema/src/core/utils/string_manager.dart';

import '../../core/helpers/date_handler.dart';

import '../../data/models/load.dart';

class LoadItem extends StatefulWidget {
  const LoadItem(
      {super.key,
      required this.load,
      required this.detailsButton,
      required this.longPressed,
      required this.onPressed});
  final Load load;
  final VoidCallback detailsButton;
  final VoidCallback longPressed;
  final VoidCallback onPressed;
  // String? origin;
  // String? destination;

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
      onTap: widget.onPressed,
      onLongPress: () {
        ispressed = !ispressed;
        widget.longPressed();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
            color: ColorManager.mouvemaWhite,
            boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.grey)],
            border:
                ispressed ? Border.all(color: Colors.teal, width: 2) : null),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(children: [
          // ***** little banner ******
          Row(
            children: [
              Text(
                '${StringManager.age}: ${DateHandler.handleAge(age)}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Spacer(),
              Text(
                DateHandler.formatDate(widget.load.loadDate.toString()),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Spacer(),
              SvgPicture.asset(
                'assets/images/${widget.load.truckType}.svg',
                width: 25,
                height: 25,
                // ignore: deprecated_member_use
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Icon(
                Icons.arrow_circle_up,
                size: 20,
                color: Colors.green,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                widget.load.origin,
                style: Theme.of(context).textTheme.titleMedium,
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
                size: 20,
                color: Colors.red,
              ),
              const SizedBox(width: 15),
              Text(
                widget.load.desitnation,
                style: Theme.of(context).textTheme.titleMedium,
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
                    StringManager.broker,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    widget.load.brokerName,
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
              const Spacer(),
              FilledButton(
                onPressed: widget.detailsButton,
                child: Text(
                  StringManager.viewDetails,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
