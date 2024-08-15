import 'package:equatable/equatable.dart';

abstract class UpdateUserEvent extends Equatable{
  const UpdateUserEvent();

  @override
  List<Object?> get props => [];
}

class UpdateUserNameAndPhoto extends UpdateUserEvent {
  final String name;
  final String imageUrl;

  const UpdateUserNameAndPhoto({required this.name, required this.imageUrl});

  @override
  List<Object?> get props => [name, imageUrl];
}

