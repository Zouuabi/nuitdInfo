import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart' show TextEditingController;

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  /// Todo : rodhom private + add getters
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  DateTime? birth;

  void dateAdded(String date) {
    emit(RegisterDateAdded(date: date));
  }
}
