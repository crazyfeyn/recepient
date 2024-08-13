part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginUserEvent extends AuthEvent {
  final String email;
  final String password;

  LoginUserEvent({required this.email, required this.password});
}

final class RegisterUserEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  RegisterUserEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

final class ResetPasswordEvent extends AuthEvent {
  final String email;
  ResetPasswordEvent({required this.email});
}

final class WatchAuthEvent extends AuthEvent {}

final class LogoutEvent extends AuthEvent {}


