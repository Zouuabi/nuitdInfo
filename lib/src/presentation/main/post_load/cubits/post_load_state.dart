import 'package:equatable/equatable.dart';

abstract class PostState extends Equatable {
  @override
  get props => [];
}

class InitialPost extends PostState {}
class PostLoading extends PostState {}

class PostError extends PostState {
  final String errrorMessage;
  PostError({required this.errrorMessage});
  @override
  get props => [errrorMessage];
}

class PostComplete extends PostState {}
