import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvema/src/presentation/main/myloads/cubit/myload_state.dart';
import '../../../../data/repository/repository_impl.dart';

class MyLoadCubit extends Cubit<MyLoadState> {
  MyLoadCubit({required this.repositoryImpl})
      : super(const MyLoadState(stutes: States.intital)) {
    getMyLoads();
  }
  final RepositoryImpl repositoryImpl;

  getMyLoads() async {
    //TODO: bech nbadlouha bel local storage

    emit(const MyLoadState(stutes: States.loading));

    var result = await repositoryImpl.getCurrentUserInformation();
    result.fold((l) {
      emit(MyLoadState(stutes: States.error, message: l.errrorMessage));
    }, (r) async {
      var readingLoadsResult = await repositoryImpl.readFavoriteLoads();
      readingLoadsResult.fold(
        (l) {
          emit(const MyLoadState(
              stutes: States.error, message: 'something went wrong'));
        },
        (r) {
          emit(MyLoadState(stutes: States.compelted, data: r));
        },
      );
    });
  }
}
