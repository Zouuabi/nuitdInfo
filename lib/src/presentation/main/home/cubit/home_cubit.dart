import 'package:dartz/dartz.dart';
import 'package:doft/src/core/failure.dart';

import 'package:doft/src/presentation/main/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/load.dart';
import '../../../../data/repository/repository_impl.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repos) : super(HomeLoading()) {
    getloads();
    // fonction thabet awwl marra wella le
    _checkFirstTime();
    print(isFirstTime);
  }
  final RepositoryImpl repos;
  List<Load?> listLoads = [];
  bool isFirstTime = false;
  void _checkFirstTime() async {
    var result = await repos.isFirstTime();
    result.fold((l) {
      emit(HomeError(message: l.errrorMessage));
    }, (r) {
      isFirstTime = r;
      print('sddff$isFirstTime');
    });
  }

  void filterLoads({String? origin, String? destination, String? type}) {
    emit(HomeLoading());
    List<Load?> filteredList = listLoads.where((load) {
      return (origin == null || load!.origin == origin) &&
          (destination == null || load!.destination == destination) &&
          (type == null || load!.truckType == type);
    }).toList();
    emit(HomeLoadingCompeleted(loads: [null, ...filteredList]));
  }

  void getloads({bool isrefresh = false}) async {
    if (!isrefresh) {
      emit(HomeLoading());
    }
    Either<Failure, List<Load?>> result = await repos.readLoads();
    result.fold(
      (failure) {
        emit(HomeError(message: failure.errrorMessage));
      },
      (loads) {
        listLoads.addAll(loads);

        emit(HomeLoadingCompeleted(loads: [null, ...loads]));
      },
    );
  }
}
