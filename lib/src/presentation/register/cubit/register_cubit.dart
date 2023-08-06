import 'dart:typed_data';

import 'package:doft/src/domain/repositories/repositories.dart';
import 'package:flutter/material.dart' show TextEditingController;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/image_picker.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._repositoryImpl) : super(RegisterInitial());

  final Repository _repositoryImpl;

  /// Todo : rodhom private + add getters
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String birth = 'YYYY-MM-DD';
  Uint8List? photo;

  void dateAdded(String date) {
    emit(RegisterDateAdded(date: date));
    birth = date.substring(0, 9);
  }

  void addPhoto() async {
    photo = await takepicture();
    if (photo != null) {
      emit(RegisterPhotoAdded(photo: photo!));
    }
  }

  void register() async {
    if (usernameController.text.isEmpty) {
      emit(const RegisterError(errorMessage: 'username empty'));
    } else if (birth == 'null') {
      emit(const RegisterError(errorMessage: 'date empty'));
    } else if (emailController.text.isEmpty) {
      emit(const RegisterError(errorMessage: 'email empty'));
    } else if (passwordController.text.isEmpty) {
      emit(const RegisterError(errorMessage: 'password empty'));
    } else {
      var result = await _repositoryImpl.register(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          birthdate: birth,
          image: photo,
          username: usernameController.text);

      result.fold(
        (failure) => emit(RegisterError(errorMessage: failure.errrorMessage)),
        (vd) {
          emit(RegisterSubmited());
        },
      );
    }
  }
}
