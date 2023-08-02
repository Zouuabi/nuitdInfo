part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterDateAdded extends RegisterState {
  final String date;
  const RegisterDateAdded({required this.date});

  @override
  List<Object> get props => [date];
}

class RegisterLoading extends RegisterState {}

class RegisterError extends RegisterState {
  final String errorMessage;
  const RegisterError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class RegisterComplete extends RegisterState {}
