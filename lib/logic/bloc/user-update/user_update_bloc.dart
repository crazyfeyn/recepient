import 'package:bloc/bloc.dart';
import 'package:flutter_application/data/services/user/firebase_user_service.dart';
import 'package:flutter_application/logic/bloc/user-update/user_update_event.dart';
import 'package:flutter_application/logic/bloc/user-update/user_update_state.dart';



class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final FirebaseUserService firebaseUserService;

  UpdateUserBloc({required this.firebaseUserService}) : super(UpdateUserInitial()) {
    // Registering the event handler
    on<UpdateUserNameAndPhoto>(_onUpdateUserNameAndPhoto);
  }

  Future<void> _onUpdateUserNameAndPhoto(
      UpdateUserNameAndPhoto event, Emitter<UpdateUserState> emit) async {
    emit(UpdateUserLoading());
    try {
      await firebaseUserService.updateUserNameAndPhoto(event.name, event.imageUrl);
      emit(UpdateUserSuccess());
    } catch (e) {
      emit(UpdateUserFailure(error: e.toString()));
    }
  }
}
