import 'package:equatable/equatable.dart';

import '../../../data/models/load.dart';

enum States { initial, loading, complete, error }

class MyloadsState extends Equatable {
  const MyloadsState({required this.status, this.data, this.message});
  final States status;
  final String? message;
  final List<Load>? data;
  @override
  List<Object?> get props => [status, message, data];
}
