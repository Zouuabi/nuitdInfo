import 'package:dartz/dartz.dart';
import 'package:doft/src/core/failure.dart';
import 'package:doft/src/domain/repositories/repositories.dart';
import 'package:doft/src/presentation/main/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/load.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repos) : super(HomeLoading()) {
    getloads();
  }
  final Repository repos;
  List<Load?> listLoads = [];

  List<Load?> filterLoads({String? origin, String? destination, String? type}) {
    List<Load?> filteredList = listLoads.where((load) {
      return (origin == null || load!.origin == origin) &&
          (destination == null || load!.destination == destination) &&
          (type == null || load!.truckType == type);
    }).toList();
    return filteredList;
  }

  void getloads() async {
    emit(HomeLoading());
    Either<Failure, List<Load?>> result = await repos.readLoads();
    result.fold(
      (failure) {
        emit(HomeError(message: failure.errrorMessage));
      },
      (loads) {
        listLoads = loads;
        emit(HomeLoadingCompeleted(loads: [null, ...loads]));
      },
    );
  }
}
