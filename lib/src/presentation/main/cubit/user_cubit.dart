import 'package:dartz/dartz.dart';
import 'package:doft/src/core/failure.dart';
import 'package:doft/src/domain/repositories/repositories.dart';
import 'package:doft/src/presentation/main/cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.repositoryImp) : super(UserInitial()) {
    getCurrentUser();
  }
  final Repository repositoryImp;

  late MyUser currentUser;

  void getCurrentUser() async {
    Either<Failure, MyUser> result =
        await repositoryImp.getCurrentUserInformation();
    result.fold(
      (l) {
        emit(UserError(errormessage: 'Error !!'));
      },
      (r) {
        currentUser = r;
        emit(UserConnected(user: r));
      },
    );
  }
}
