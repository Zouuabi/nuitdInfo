import 'package:equatable/equatable.dart';

import '../../../../data/models/load.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  HomeError({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}

class HomeLoadingCompeleted extends HomeState {
  HomeLoadingCompeleted({required this.loads});
  final List<Load?> loads;
  @override
  List<Object?> get props => [loads];
}
