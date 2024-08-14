import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_application/data/model/recipe.dart';

class RecipeController {
  final Dio _dio = Dio();

  Future<void> addRecipe(Recipe recipe) async {
    const url =
        'https://retsept-app-db287-default-rtdb.firebaseio.com/recipes.json';

    try {
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
        print('Recipe added successfully!');
      } else {
        print('Failed to add recipe: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding recipe: $e');
    }
  }

  Future<List<Recipe>> fetchRecipes() async {
    const url =
        'https://retsept-app-db287-default-rtdb.firebaseio.com/recipes.json';

    try {
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
