import 'package:equatable/equatable.dart';
import 'package:flutter_application/data/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';
part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState());

  void toggleLike(event, emit, String recipeId) {
    final user = state.currentUser;
    // user!.likes.add();
    emit(
      state.copyWith(currentUser: user),
    );
  }
}
