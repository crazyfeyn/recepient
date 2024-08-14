part of 'home_bloc.dart';

sealed class HomeEvent {}

final class FetchRecipesEvent extends HomeEvent {}

final class ToggleLikeEvent extends HomeEvent {
  String uId;
  String recipeId;

  ToggleLikeEvent(this.uId, this.recipeId);
}
