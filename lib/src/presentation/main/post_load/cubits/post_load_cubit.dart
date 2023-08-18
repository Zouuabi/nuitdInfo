import 'package:dartz/dartz.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvema/src/presentation/main/post_load/cubits/post_load_state.dart';

import '../../../../core/failure.dart';
import '../../../../data/models/load.dart';
import '../../../../domain/repositories/repositories.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this._repository) : super(InitialPost());

  final Repository _repository;
  String? truckType;

  void postLoad(Load load) async {
    emit(PostLoading());

    Either<Failure, void> result =
        await _repository.postLoad(load.toFirestore());

    result.fold((l) => emit(PostError(errrorMessage: l.errrorMessage)),
        (r) => emit(PostComplete()));
  }
}
