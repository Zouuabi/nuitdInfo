import 'package:flutter/material.dart';

import 'interaction_button.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.likesNum,
    required this.lovesNum,
    required this.onPressed,
  });
  final VoidCallback onPressed;
  final String imageUrl;
  final String title;
  final int likesNum;
  final int lovesNum;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        height: 200,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Expanded(
                    child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                )),
                Expanded(
                    child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ))
              ]),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InteractionButton(
                      icon: const Icon(Icons.heart_broken), number: likesNum),
                  const SizedBox(width: 10),
                  InteractionButton(
                      icon: const Icon(Icons.chat_bubble_outline),
                      number: lovesNum),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
