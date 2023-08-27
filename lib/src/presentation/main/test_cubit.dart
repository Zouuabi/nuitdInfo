import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:equatable/equatable.dart';

enum Status { initial, placeSelectionSucc, placeSelectionfailed }

class TestState extends Equatable {
  const TestState({required this.status, this.errorMessage, this.data});

  final Status status;
  final String? errorMessage;
  final LatLng? data;
  @override
  List<Object?> get props => [status, errorMessage, data];
}

class TestCubit extends Cubit<TestState> {
  TestCubit() : super(const TestState(status: Status.initial));

  void updateLocation(LatLng position) {
    emit(TestState(status: Status.placeSelectionSucc, data: position));
  }
}
