import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_application/data/model/recipe.dart';
import 'package:flutter_application/data/services/firebase/firebase_storage_service.dart';
import 'package:flutter_application/data/services/recipes/firebase_recipe_service.dart';

class RecipeController {
  final firebaseRecipeService = FirebaseRecipeService();

  /// Adds a new recipe to Firebase Realtime Database
  Future<bool> addRecipe(Recipe recipe) async {
    FirebaseStorageService firebaseStorageService = FirebaseStorageService();
    if (recipe.videoUrl.isNotEmpty) {
      recipe.videoUrl = await firebaseStorageService.uploadVideo(
              File(recipe.videoUrl), recipe.title) ??
          "";
    }

    recipe.imageUrl = await firebaseStorageService.uploadImageToFirebase(
            File(recipe.imageUrl), recipe.title) ??
        "";

    const url =
        'https://retsept-app-db287-default-rtdb.firebaseio.com/recipes.json';

    try {
      // Convert the recipe object to JSON
      final response = await _dio.post(
        url,
        data: json.encode(recipe.toJson()),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
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
