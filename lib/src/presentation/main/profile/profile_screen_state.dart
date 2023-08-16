part of 'profile_screen_cubit.dart';

enum Status { initial, loading, success, failed }

class ProfileScreenState extends Equatable {
  const ProfileScreenState(
      {required this.status, this.errorMessage, this.data});

  final Status status;
  final String? errorMessage;
  final dynamic data;

  @override
  List<Object?> get props => [status, data, errorMessage];
}
