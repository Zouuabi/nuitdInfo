import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:doft/src/domain/repositories/repositories.dart';

import 'package:flutter/material.dart' show TextEditingController;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/failure.dart';
import '../../../core/helpers/image_picker.dart';
import '../../../data/repository/repository_impl.dart';

part 'profile_screen_state.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  ProfileScreenCubit(this.repositoryImpl)
      : super(const ProfileScreenState(status: Status.initial));

  final RepositoryImpl repositoryImpl;

  TextEditingController usernameController = TextEditingController();
  TextEditingController telController = TextEditingController();

  String birth = 'YYYY-MM-DD';
  Uint8List? photo;

  // void dateAdded(String date) {
  //   emit(ProfilDateAdded(date: date));
  //   birth = date.substring(0, 9);
  // }

  // void addPhoto() async {
  //   photo = await takepicture();
  //   if (photo != null) {
  //     emit(ProfilPhotoAdded(photo: photo!));
  //   }
  // }

  void logout() async {
    emit(const ProfileScreenState(status: Status.loading));

    Either<Failure, void> result = await repositoryImpl.logOut();

    result.fold(
        (l) => emit(ProfileScreenState(
            status: Status.failed, errorMessage: l.errrorMessage)),
        (r) => emit(const ProfileScreenState(status: Status.success)));
  }

  // void fillProfile() async {
  //   if (usernameController.text.isEmpty) {
  //     emit(const ProfilError(errorMessage: 'username empty'));
  //   } else if (birth == 'null') {
  //     emit(const ProfilError(errorMessage: 'date empty'));
  //   } else {
  //     emit(ProfilLoading());
  //     var result = await repositoryImpl.register(
  //         username: usernameController.text,
  //         birthdate: birth,
  //         tel: telController.text,
  //         image: photo);
  //     result.fold(
  //       (failure) {
  //         emit(ProfilError(errorMessage: failure.errrorMessage));
  //       },
  //       (vd) {
  //         emit(ProfilSubmited());
  //       },
  //     );
  //   }
  // }
}
