import 'package:dartz/dartz.dart';
import 'package:doft/src/core/failure.dart';
import 'package:doft/src/domain/repositories/repositories.dart';
import 'package:doft/src/presentation/main/home/pages/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/load.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repos) : super(InitialeState()) {
    getloads();
  }
  final Repository repos;

  List<Load> loads = [];

  void getloads() async {
    emit(LoadingState());
    Either<Failure, List<Load>> result = await repos.readLoads();
    result.fold(
      (l) {
        print('readloads');
        emit(HomeError(message: l.errrorMessage));
      },
      (r) {
        print('rigth');
        loads = r;
        emit(HomeLoadingCompeleted(loads: loads));
      },
    );
  }
}
