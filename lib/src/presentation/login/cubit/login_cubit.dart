import 'package:dartz/dartz.dart';
import 'package:doft/src/core/helpers/email_checker.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/failure.dart';
import '../../../domain/repositories/repositories.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginScreenState> {
  LoginCubit(this.repositoryImpl)
      : super(const LoginScreenState(status: Status.initial));
  Repository repositoryImpl;

  bool isEmailEmpty = false;
  bool isPasswordEmpty = false;

  // bool _isvalid() {
  //   bool valid = true;
  //   if (_emailController.text.isEmpty) {
  //     isEmailEmpty = true;
  //     valid = false;
  //   }

  //   if (_passwordController.text.isEmpty) {
  //     isPasswordEmpty = true;
  //     valid = false;
  //   }
  //   return valid;
  // }

//   void signIn() async {
//     emit();
//     if (!_isvalid()) {
//       return;
//     }

//     isValidEmail(_emailController.text);

//     emit(LoginLoading());
//     if (!isValidEmail(_emailController.text)) {
//       emit(const LoginError(errorMessage: 'Invalid Email'));
//       return;
//     }
//     Either<Failure, void> result = await repositoryImpl.signIn(
//         _emailController.text, _passwordController.text);

//     result.fold(
//         (failure) => emit(LoginError(errorMessage: failure.errrorMessage)),
//         (complete) => emit(LoginComplete()));
//   }
// }
}
