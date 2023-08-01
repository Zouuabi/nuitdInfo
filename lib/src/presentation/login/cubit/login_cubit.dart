import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/failure.dart';
import '../../../domain/repositories/repositories.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.repositoryImpl) : super(LoginInitial());
  Repository repositoryImpl;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordContriller => _passwordController;

  void signIn() async {
    emit(LoginInitial());
    emit(LoginLoading());

    Either<Failure, void> result = await repositoryImpl.signIn(
        _emailController.text, _passwordController.text);

    result.fold(
        (failure) => emit(LoginError(errorMessage: failure.errrorMessage)),
        (complete) => emit(LoginComplete()));
  }
}
