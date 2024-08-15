part of 'home_bloc.dart';

sealed class HomeEvent {}

final class FetchRecipesEvent extends HomeEvent {}

final class ToggleLikeEvent extends HomeEvent {
  String uId;
  String recipeId;

  ToggleLikeEvent(this.uId, this.recipeId);
}

final class GetLatestRecipesEvent extends HomeEvent {}

final class GetTrendingRecipesEvent extends HomeEvent {}

final class GetShortPreparedRecipesEvent extends HomeEvent {}

final class AddReviewEvent extends HomeEvent {
  final String recipeId;
  final Map<String, dynamic> review;

  AddReviewEvent(this.recipeId, this.review);
}
