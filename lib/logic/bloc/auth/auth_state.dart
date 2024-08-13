part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class InitialAuthState extends AuthState {}

final class LoadingAuthState extends AuthState {}

final class UnauthenticatedState extends AuthState {}

final class AuthenticatedState extends AuthState {}
final class RestPasswordState extends AuthState {}



final class ErrorAuthState extends AuthState {
  final String errorMessage;

  ErrorAuthState({required this.errorMessage});
}