part of 'home_bloc.dart';

sealed class HomeState {}

final class InitialState extends HomeState {}

final class LoadingState extends HomeState {}

final class LoadedState extends HomeState {
  List<Recipe> recipes;

  LoadedState(this.recipes);
}

final class ErrorState extends HomeState {
  String message;

  ErrorState(this.message);
}
