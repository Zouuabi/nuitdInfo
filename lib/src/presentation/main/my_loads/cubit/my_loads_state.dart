import 'package:equatable/equatable.dart';

import '../../../../data/models/load.dart';

enum Status { initial, loading, success, failed }

class MyloadsState extends Equatable {
  const MyloadsState({required this.status, this.data, this.message});
  final Status status;
  final String? message;
  final List<Load>? data;
  @override
  List<Object?> get props => [status, message, data];
}
