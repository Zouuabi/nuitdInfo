import 'package:equatable/equatable.dart';

import '../../../../data/models/load.dart';

enum States { intital, loading, compelted, error, refresh }

class FavoritesState extends Equatable {
  const FavoritesState({required this.status, this.data, this.message});
  final States status;
  final String? message;
  final List<Load>? data;

  @override
  List<Object?> get props => [status, data, message];
}
