import 'package:dartz/dartz.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/failure.dart';
import '../../../../data/models/load.dart';
import '../../../../domain/repositories/repositories.dart';
import 'my_loads_state.dart';

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

  void deleteLoads(List<String> loads) async {
    Either<Failure, void> result = await _repository.deleteLoads(loads: loads);
    result.fold((l) {
      emit(MyloadsState(status: States.error, message: l.errrorMessage));
    }, (r) {
      fetchMyLoads();
    });
  }
}
