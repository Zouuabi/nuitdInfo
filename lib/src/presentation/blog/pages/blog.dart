import 'package:flutter/material.dart';
import 'package:mouvema/src/presentation/blog/widgets/article.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: ScrollController(),
      slivers: [
        SliverAppBar(
          title: Text('title'),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        SliverList.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              return ArticleItem(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/articleDetails',
                  );
                },
                imageUrl:
                    'https://upload.wikimedia.org/wikipedia/commons/2/2a/Keyboard-anykey.jpg',
                likesNum: 20,
                lovesNum: 50,
                title: 'this is the title of the article',
              );
            })
      ],
    );
  }
}
