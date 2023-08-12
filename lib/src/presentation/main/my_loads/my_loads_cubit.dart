import 'package:dartz/dartz.dart';
import 'package:doft/src/core/failure.dart';
import 'package:doft/src/domain/repositories/repositories.dart';
import 'package:doft/src/presentation/main/my_loads/my_loads_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/load.dart';

class MyLoadsCubit extends Cubit<MyloadsState> {
  MyLoadsCubit(this._repository)
      : super(const MyloadsState(status: States.initial)) {
    fetchMyLoads();
  }

  final Repository _repository;

  void fetchMyLoads({bool refresh = false}) async {
    if (!refresh) {
      emit(const MyloadsState(status: States.loading));
    }

    Either<Failure, List<Load>> result = await _repository.readMyLoads();

    result.fold(
        (l) =>
            emit(MyloadsState(status: States.error, message: l.errrorMessage)),
        (r) => emit(MyloadsState(status: States.complete, data: r)));
  }
}
