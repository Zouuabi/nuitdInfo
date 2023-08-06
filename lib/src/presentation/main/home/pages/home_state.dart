import 'package:doft/src/data/models/load.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingState extends HomeState {}

class HomeError extends HomeState {
  HomeError({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}

class HomeLoadingCompeleted extends HomeState {
  HomeLoadingCompeleted({required this.loads});
  final List<Load> loads;
  @override
  List<Object?> get props => [loads];
}

class InitialeState extends HomeState {}
