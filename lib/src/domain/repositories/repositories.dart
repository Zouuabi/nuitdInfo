import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/failure.dart';

abstract class Repository {
  
  Future<Either<Failure, void>> signIn(String email, String password);
  Future<Either<Failure, User>> createUser(String email, String password);

}


