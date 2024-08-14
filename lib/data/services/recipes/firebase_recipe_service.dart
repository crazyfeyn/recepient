import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_application/data/model/recipe.dart';

class FirebaseRecipeService {
  final _dio = Dio();
  final String baseUrl =
      'https://retsept-app-db287-default-rtdb.firebaseio.com';

 Future<List<Recipe>?> getRecipes() async {
  try {
    final response = await _dio.get('$baseUrl/recipes.json');
    if (response.data != null) {
      final recipesData = Map<String, dynamic>.from(response.data);
      final recipesList = recipesData.entries.map((entry) {
        final recipeJson = Map<String, dynamic>.from(entry.value);
        recipeJson['id'] = entry.key; // Ensure the id is set
        return Recipe.fromJson(recipeJson);
      }).toList();
      return recipesList;
    } else {
      return null;
    }
  } on DioException catch (e) {
    throw e.response?.data ?? 'An error occurred';
  } catch (e) {
    rethrow;
  }
}

  Future<void> addRecipe(Recipe recipe) async {
    try {
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
