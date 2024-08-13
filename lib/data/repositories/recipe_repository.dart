import 'package:flutter_application/data/model/recipe.dart';
import 'package:flutter_application/data/services/recipes/firebase_recipe_service.dart';

class RecipeRepository {
  final FirebaseRecipeService _firebaseRecipeService = FirebaseRecipeService();

  Stream<List<Recipe>?> getRecipes() {
    return _firebaseRecipeService.getRecipes();
  }
}
