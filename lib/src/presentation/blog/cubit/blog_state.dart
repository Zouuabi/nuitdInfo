import 'package:equatable/equatable.dart';

import '../../../data/models/article.dart';

enum Status { initial, loading, fetchSuccess, fetchFailed }

class FeedState extends Equatable {
  const FeedState({required this.status, this.errorMessage, this.data});
  final Status status;

  final String? errorMessage;
  final List<Article>? data;

  @override
  List<Object?> get props => [status, errorMessage, data];
}
