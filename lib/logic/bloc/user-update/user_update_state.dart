import 'package:equatable/equatable.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object?> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoading extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {}

class UpdateUserFailure extends UpdateUserState {
  final String error;

  const UpdateUserFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
