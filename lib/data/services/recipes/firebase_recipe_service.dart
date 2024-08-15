// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_application/data/model/comment.dart';
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
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<List<Recipe>?> getTrendingRecipes() async {
    try {
      final recipes = await getRecipes();
      if (recipes != null) {
        recipes.sort((a, b) => FirebaseRecipeService.calculateRating(b.rate)
            .compareTo(FirebaseRecipeService.calculateRating(a.rate)));
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
            .where((recipe) => recipe.estimatedTime.inMinutes <= 15)
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
      } else {
      }
    } catch (e) {
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
      } else {
      }
    } catch (e) {
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
      } else {
      }
    } catch (e) {
    }
  }

  /// berilgan ratingni hisoblash uchun
  static double calculateRating(List<int> rate) {
    if (rate.isEmpty) return 0.0;
    int sum = 0;
    for (var i in rate) {
      sum += i;
    }
    return sum / rate.length;
  }

  /// kommentlarni firebasega qo'shish
  Future<void> addReviewComment(String recipeId, Comment review) async {
    try {
      final response = await _dio.post(
        "$baseUrl/recipes/$recipeId/review.json",
        data: json.encode(review),
        options: Options(headers: {'Contant-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
      } else {
      }
    } catch (e) {
      rethrow;
    }
  }

  /// kommentlarni firebasedan olish
  Future<List<Comment>> getReviewComments(String recipeId) async {
    try {
      final response = await _dio.get(
        "$baseUrl/recipes/$recipeId/review.json",
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;

        final List<Comment> comments = [];
        data.forEach(
          (key, value) {
            comments.add(Comment.fromJson(value));
          },
        );

        return comments;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}
