import 'package:equatable/equatable.dart';

class Article extends Equatable {
  const Article({
    required this.title,
    required this.imageUrl,
    required this.content,
    required this.likesNum,
    required this.lovesNum,
  });

  final String title;
  final String imageUrl;
  final String content;
  final int likesNum;
  final int lovesNum;

  factory Article.fromFirestore(Map<String, dynamic> map) {
    return Article(
      title: map['title'] ?? 'null',
      imageUrl: map['imageUrl'] ?? 'null',
      content: map['content'] ?? 'null',
      likesNum: map['likesNum'] ?? 'null',
      lovesNum: map['lovesNum'] ?? 'null',
    );
  }

  Map<String, dynamic> toFirestore() => {
        'title': title,
        'imageUrl': imageUrl,
        'content': content,
        'likesNum': likesNum,
        'lovesNum': lovesNum,
      };

  @override
  List<Object?> get props => [title, imageUrl, content];
}
