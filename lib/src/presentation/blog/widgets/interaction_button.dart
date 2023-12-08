import 'package:flutter/material.dart';

class InteractionButton extends StatelessWidget {
  const InteractionButton({
    super.key,
    required this.number,
    required this.icon,
  });
  final int number;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: icon,
        ),
        const SizedBox(width: 5),
        Text(
          ' $number Likes',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
