import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart' show ScrollController;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvema/src/presentation/main/kanawita/cubit/home_state.dart';
import '../../../../core/failure.dart';
import '../../../../data/models/load.dart';
import '../../../../data/repository/repository_impl.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repos) : super(const HomeState(status: Status.initial)) {
    fetchLoads();
    _checkFirstTime();
  }
  final RepositoryImpl repos;
  // final ScrollController _scrollController = ScrollController();
  List<Load> listLoads = [];
  bool isFirstTime = false;

  void _checkFirstTime() async {
    var result = await repos.isFirstTime();
    result.fold((l) {
      emit(
          HomeState(status: Status.fetchFailed, errorMessage: l.errrorMessage));
    }, (r) {
      isFirstTime = r;
    });
  }

  void filterLoads({String? origin, String? destination, String? type}) {
    emit(const HomeState(status: Status.loading));
    List<Load> filteredList = listLoads.where((load) {
      return /*(origin == null || load.origin == origin) &&
          (destination == null || load.destination == destination) &&*/
          (type == null || load.truckType == type);
    }).toList();
    emit(HomeState(status: Status.fetchSuccess, data: filteredList));
  }

  void fetchLoads({bool isrefresh = false}) async {
    if (!isClosed) {
      if (!isrefresh) {
        emit(const HomeState(status: Status.loading));
      }
      Either<Failure, List<Load>> result = await repos.fetchLoads();
      result.fold(
        (failure) {
          emit(HomeState(
              status: Status.fetchFailed, errorMessage: failure.errrorMessage));
        },
        (loads) {
          listLoads.addAll(loads);
          emit(HomeState(status: Status.fetchSuccess, data: loads));
        },
      );
    }
  }
}
