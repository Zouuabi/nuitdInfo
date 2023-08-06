import 'package:dartz/dartz.dart';
import 'package:doft/src/core/failure.dart';
import 'package:doft/src/domain/repositories/repositories.dart';
import 'package:doft/src/presentation/main/home/pages/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/load.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repos) : super(HomeLoading()) {
    getloads();
  }
  final Repository repos;

  void getloads() async {
    emit(HomeLoading());
    Either<Failure, List<Load>> result = await repos.readLoads();
    result.fold(
      (failure) {
        emit(HomeError(message: failure.errrorMessage));
      },
      (loads) {
          
        emit(HomeLoadingCompeleted(loads: loads));
      },
    );
  }
}
