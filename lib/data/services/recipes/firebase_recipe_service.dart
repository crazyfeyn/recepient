import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_application/data/model/recipe.dart';

class FirebaseRecipeService {
  final _dio = Dio();
  final String baseUrl =
      'https://retsept-app-db287-default-rtdb.firebaseio.com/recipes';

  Stream<List<Recipe>?> getRecipes() async* {
    try {
      final response = await _dio.get('$baseUrl/recipes.json');
      if (response.data != null) {
        final recipesData = Map<String, dynamic>.from(response.data);
        final recipesList = recipesData.entries.map((entry) {
          final recipeJson = entry.value as Map<String, dynamic>;
          return Recipe.fromJson(recipeJson);
        }).toList();
        yield recipesList;
      } else {
        yield null;
      }
    } on DioException catch (e) {
      throw e.response!.data;
    } catch (e) {
      rethrow;
    }
  }

  /// Adds a new recipe to Firebase Realtime Database
  Future<void> addRecipe(Recipe recipe) async {
    try {
      // Convert the recipe object to JSON
      final response = await _dio.post(
        '$baseUrl.json',
        data: json.encode(recipe.toJson()),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Recipe added successfully!');
      } else {
        print('Failed to add recipe: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding recipe: $e');
    }
  }

  /// Edits an existing recipe in Firebase Realtime Database
  Future<void> editRecipe(String recipeId, Recipe updatedRecipe) async {
    try {
      final response = await _dio.patch(
        '$baseUrl/$recipeId.json',
        data: json.encode(updatedRecipe.toJson()),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Recipe updated successfully!');
      } else {
        print('Failed to update recipe: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating recipe: $e');
    }
  }

  /// Deletes a recipe from Firebase Realtime Database
  Future<void> deleteRecipe(String recipeId) async {
    try {
      final response = await _dio.delete(
        '$baseUrl/$recipeId.json',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Recipe deleted successfully!');
      } else {
        print('Failed to delete recipe: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting recipe: $e');
    }
  }
}
