import 'package:flutter_application/controllers/recipe_controller.dart';
import 'package:flutter_application/data/model/recipe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialState()) {
    on<FetchRecipesEvent>(fetchRecipes);
  }

  Future<void> fetchRecipes(event, emit) async {
    try {
      final recipeController = RecipeController();
      emit(LoadingState());
      List<Recipe> recipes = await recipeController.fetchRecipes();
      emit(LoadedState(recipes));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
