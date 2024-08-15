part of 'user_bloc.dart';

// ignore: must_be_immutable
final class UserState extends Equatable {
  UserModel? currentUser;
 

  UserState([this.currentUser]);

  UserState copyWith({
    UserModel? currentUser,
  }) {
    return UserState(currentUser);
  }

  @override
  List<Object?> get props => [currentUser];
}
