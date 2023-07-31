import 'package:dartz/dartz.dart';
import 'package:doft/src/data/repository/repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/failure.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.repositoryImpl) : super(LoginInitial());
  RepositoryImpl repositoryImpl;

  void signIn(String email, String password) async {
    emit(LoginLoading());

    Either<Failure, void> result = await repositoryImpl.signIn(email, password);

    result.fold(
        (failure) => emit(LoginError(errorMessage: failure.errrorMessage)),
        (complete)=>emit(LoginComplete()));
  }
}
