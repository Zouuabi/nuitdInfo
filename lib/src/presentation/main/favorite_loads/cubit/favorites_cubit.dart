import 'package:doft/src/data/repository/repository_impl.dart';
import 'package:doft/src/presentation/main/favorite_loads/cubit/favorites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({required this.repositoryImpl})
      : super(const FavoritesState(status: States.intital)) {
    getMyLoads();
  }
  final RepositoryImpl repositoryImpl;

  void getMyLoads({bool refresh = false}) async {
    if (!refresh) {
      emit(const FavoritesState(status: States.loading));
    }

    var readingLoadsResult = await repositoryImpl.readFavoriteLoads();
    if (!isClosed) {
      readingLoadsResult.fold(
        (l) {
          emit(const FavoritesState(
              status: States.error, message: 'something went wrong'));
        },
        (r) {
          emit(FavoritesState(status: States.compelted, data: r));
        },
      );
    }
  }
}