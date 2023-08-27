import 'package:equatable/equatable.dart';

import '../../../../data/models/load.dart';

enum Status { intital, loading, success, failed }

class FavoritesState extends Equatable {
  const FavoritesState({required this.status, this.data, this.message});
  final Status status;
  final String? message;
  final List<Load>? data;

  @override
  List<Object?> get props => [status, data, message];
}
