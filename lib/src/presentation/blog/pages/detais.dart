import 'package:flutter/material.dart';

import '../../../data/models/article.dart';

class Details extends StatelessWidget {
  const Details({super.key, required this.articleItem});

  final Article articleItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
      ),
      body: Column(
        children: [
          Expanded(flex: 2, child: Image.network(articleItem.imageUrl)),
          const SizedBox(height: 20),
          Text(
            articleItem.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 20),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  articleItem.content,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )),
        ],
      ),
    );
  }
}
