part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginError extends LoginState {
  final String errorMessage;
  const LoginError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class LoginComplete extends LoginState {
  @override
  List<Object> get props => [];
}
