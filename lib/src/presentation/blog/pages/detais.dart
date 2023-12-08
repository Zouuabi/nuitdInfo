import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  // final ArticleItem article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/2/2a/Keyboard-anykey.jpg')),
          Expanded(
              flex: 2,
              child: Text(
                '''
          Here goes the text of your article. 
          You can provide a detailed description of the content here.
          Feel free to format it as needed.
        ''',
                textAlign: TextAlign.left,
              )),
          Expanded(child: Container())
        ],
      ),
    );
  }
}
