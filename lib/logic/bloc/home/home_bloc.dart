import 'package:flutter_application/controllers/recipe_controller.dart';
import 'package:flutter_application/data/model/recipe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialState()) {
    on<FetchRecipesEvent>(fetchRecipes);
    on<ToggleLikeEvent>(toggleLike);
    on<GetLatestRecipesEvent>(getLatestRecipes);
  }
  final recipeController = RecipeController();

  Future<void> fetchRecipes(event, emit) async {
    try {
      emit(LoadingState());
      List<Recipe> recipes = await recipeController.fetchRecipes();
      emit(LoadedState(recipes));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> toggleLike(ToggleLikeEvent event, emit) async {
    recipeController.toggleLike(event.uId, event.recipeId);
  }

  Future<void> getLatestRecipes(GetLatestRecipesEvent event, emit) async {
    try {
      emit(LoadingState());
      List<Recipe> recipes = recipeController.getLatestRecipes()!;
      if (recipes.isNotEmpty) {
        emit(LoadedState(recipes));
      } else {
        emit(ErrorState("No recipes found"));
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
