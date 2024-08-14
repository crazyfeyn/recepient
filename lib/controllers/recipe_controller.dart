import 'package:flutter_application/data/model/recipe.dart';
import 'package:flutter_application/data/services/recipes/firebase_recipe_service.dart';

class RecipeController {
  final firebaseRecipeService = FirebaseRecipeService();

  Future<void> addRecipe(Recipe recipe) async {
    try {
      await firebaseRecipeService.addRecipe(recipe);
    } catch (e) {
      print('Error adding recipes: $e');
    }
  }

  Future<List<Recipe>> fetchRecipes() async {
    try {
      List<Recipe>? response = await firebaseRecipeService.getRecipes();
      return response ?? [];
    } catch (e) {
      print('Error fetching recipes: $e');
      return [];
    }
  }

  Future<void> toggleLike(String uId, String recipeId) async {
    try {
      firebaseRecipeService.toggleLike(uId, recipeId);
    } catch (e) {
      print(e.toString());
    }
  }
}
