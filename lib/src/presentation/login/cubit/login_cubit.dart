import 'package:dartz/dartz.dart';
import 'package:doft/src/core/email_checker.dart';
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

  bool isEmailEmpty = false;
  bool isPasswordEmpty = false;

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordContriller => _passwordController;

  bool _isvalid() {
    bool valid = true;
    if (_emailController.text.isEmpty) {
      isEmailEmpty = true;
      valid = false;
    }

    if (_passwordController.text.isEmpty) {
      isPasswordEmpty = true;
      valid = false;
    }
    return valid;
  }

  void signIn() async {
    emit(LoginInitial());
    if (!_isvalid()) {
      return;
    }

    isValidEmail(_emailController.text);

    emit(LoginLoading());
    if (!isValidEmail(_emailController.text)) {
      emit(const LoginError(errorMessage: 'hot email mte3k f termtk'));
      return;
    }
    Either<Failure, void> result = await repositoryImpl.signIn(
        _emailController.text, _passwordController.text);

    result.fold(
        (failure) => emit(LoginError(errorMessage: failure.errrorMessage)),
        (complete) => emit(LoginComplete()));
  }
}
