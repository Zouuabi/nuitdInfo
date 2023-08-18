import 'package:equatable/equatable.dart';

import '../../../../data/models/load.dart';

enum States { intital, loading, compelted, error }

class MyLoadState extends Equatable {
  const MyLoadState({required this.stutes, this.data, this.message});
  final States stutes;
  final String? message;
  final List<Load>? data;

  @override
  List<Object?> get props => [stutes, data, message];
}
