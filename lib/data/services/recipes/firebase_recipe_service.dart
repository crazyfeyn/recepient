import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_application/data/model/recipe.dart';

class FirebaseRecipeService {
  final _dio = Dio();
  final String baseUrl =
      'https://retsept-app-db287-default-rtdb.firebaseio.com';

  Future<List<Recipe>?> getLatestRecipes() async {
    try {
      final recipes = await getRecipes();
      if (recipes != null) {
        recipes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return recipes;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Recipe>?> getTrendingRecipes() async {
    try {
      final recipes = await getRecipes();
      if (recipes != null) {
        recipes.sort((a, b) => b.rate.compareTo(a.rate));
        return recipes;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Recipe>?> getShortPreparedRecipes() async {
    try {
      final recipes = await getRecipes();
      if (recipes != null) {
        final shortRecipes = recipes
            .where((recipe) => recipe.estimatedTime.inMinutes <= 30)
            .toList();
        return shortRecipes;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Recipe>?> getRecipes() async {
    try {
      final response = await _dio.get('$baseUrl/recipes.json');
      if (response.data != null) {
        final recipesData = Map<String, dynamic>.from(response.data);
        final recipesList = recipesData.entries.map((entry) {
          final recipeJson = Map<String, dynamic>.from(entry.value);
          recipeJson['id'] = entry.key;
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

  Future<void> toggleLike(String uId, String recipeId) async {
    try {
      final response = await _dio.get('$baseUrl/recipes/$recipeId/likes.json');
      List<String> likes = [];

      if (response.data != null) {
        likes = List<String>.from(response.data);
      }

      if (likes.contains(uId)) {
        likes.remove(uId);
      } else {
        likes.add(uId);
      }

      await _dio.put(
        '$baseUrl/recipes/$recipeId/likes.json',
        data: json.encode(likes),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      print('Successfully updated likes');
    } catch (e) {
      print('Error toggling like: $e');
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
