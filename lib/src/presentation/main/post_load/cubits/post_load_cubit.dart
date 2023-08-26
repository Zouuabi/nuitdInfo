import 'package:dartz/dartz.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvema/src/core/internet_checker.dart';
import 'package:mouvema/src/presentation/main/post_load/cubits/post_load_state.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/failure.dart';
import '../../../../data/models/load.dart';
import '../../../../domain/repositories/repositories.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this._repository) : super(const PostState(status: Status.initial));

  final Repository _repository;
  String? truckType;
  LatLng? origin;
  LatLng? destination;

  Future<bool> isConnected() async {
    return await InternetCheckerImpl().isConnected();
  }

  void onPositionChanged(LatLng? origin, LatLng? destination) async {
    emit(PostState(
        status: Status.onPositionChanged, data: [origin, destination]));
  }

  void postLoad(Load load) async {
    emit(const PostState(status: Status.initial));

    Either<Failure, void> result =
        await _repository.postLoad(load.toFirestore());

    result.fold(
        (l) => emit(PostState(status: Status.failed, message: l.errrorMessage)),
        (r) => emit(const PostState(status: Status.success)));
  }
}
