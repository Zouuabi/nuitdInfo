import 'package:dartz/dartz.dart';

import '../../core/failure.dart';

abstract class Repository {
  
  Future<Either<Failure, void>> signIn(String email, String password);
  Future<Either<Failure, void>> register(String email, String password);

}


