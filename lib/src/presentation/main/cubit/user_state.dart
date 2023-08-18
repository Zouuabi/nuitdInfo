import 'package:mouvema/src/data/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserError extends UserState {
  UserError({required this.errormessage});
  final String errormessage;
  @override
  List<Object?> get props => [errormessage];
}

class UserConnected extends UserState {
  UserConnected({required this.user});
  final MyUser user;
  @override
  List<Object?> get props => [user];
}
