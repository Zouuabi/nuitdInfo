import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/failure.dart';

abstract class Repository {
  Future<Either<Failure, void>> signIn(String email, String password);
  Future<Either<Failure, void>> register(
      {required String username,
      required String birthdate,
      required String email,
      required String password,
      required Uint8List? image});
}
