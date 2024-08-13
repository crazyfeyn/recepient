// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/user_model.dart';
import 'package:flutter_application/data/repositories/auth_repository.dart';
import 'package:flutter_application/data/services/user/firebase_user_service.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(InitialAuthState()) {
    on<LoginUserEvent>(_loginUser);
    on<RegisterUserEvent>(_onRegisterUser);
    on<ResetPasswordEvent>(_onResetPassword);
    on<LogoutEvent>(_onLogoutUser);
    on<WatchAuthEvent>(_onWatchAuth);
  }
  void _loginUser(LoginUserEvent event, Emitter<AuthState> emit) async {
    emit(LoadingAuthState());
    try {
      await _authRepository.login(email: event.email, password: event.password);
      emit(AuthenticatedState());
    } catch (e) {
      emit(
        ErrorAuthState(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onRegisterUser(RegisterUserEvent event, Emitter<AuthState> emit) async {
    emit(LoadingAuthState());
    try {
      await _authRepository.register(
          email: event.email, password: event.password);
      emit(AuthenticatedState());
      FirebaseAuth.instance.currentUser!.updateDisplayName(event.name);
      FirebaseUserService().createUser(
        UserModel(
            email: event.email,
            name: event.name,
            imageUrl: '',
            uId: FirebaseAuth.instance.currentUser!.uid,
            likes: [],
            saved: []),
      );
    } catch (e) {
      emit(
        ErrorAuthState(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onResetPassword(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(LoadingAuthState());
    try {
      await _authRepository.resetPassword(email: event.email);
      emit(RestPasswordState());
    } catch (e) {
      emit(
        ErrorAuthState(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onLogoutUser(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(LoadingAuthState());
    try {
      await _authRepository.logOut();
      emit(UnauthenticatedState());
    } catch (e) {
      emit(
        ErrorAuthState(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onWatchAuth(WatchAuthEvent event, Emitter<AuthState> emit) async {
    emit(LoadingAuthState());
    try {
      emit.forEach(
        _authRepository.watchAuth(),
        onData: (user) {
          return user == null ? UnauthenticatedState() : AuthenticatedState();
        },
      );
    } catch (e) {
      emit(
        ErrorAuthState(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
