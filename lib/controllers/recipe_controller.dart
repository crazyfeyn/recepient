import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_application/data/model/recipe.dart';
import 'package:flutter_application/data/services/firebase/firebase_storage_service.dart';

class RecipeController {
  final Dio _dio = Dio();

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

  /// Fetches all recipes from Firebase Realtime Database
  Future<List<Recipe>> fetchRecipes() async {
    const url =
        'https://retsept-app-db287-default-rtdb.firebaseio.com/recipes.json';

    try {
      // Send GET request to fetch recipes
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        List<Recipe> recipes = [];

        data.forEach((key, value) {
          recipes.add(Recipe.fromJson(value));
        });

        return recipes;
      } else {
        print('Failed to fetch recipes: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching recipes: $e');
      return [];
    }
  }
}
