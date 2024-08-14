import 'package:dio/dio.dart';
import 'package:flutter_application/data/model/recipe.dart';

class FirebaseRecipeService {
  final _dio = Dio();
  final String baseUrl =
      'https://retsept-app-db287-default-rtdb.firebaseio.com/';

  Future<List<Recipe>?> getRecipes() async {
    try {
      final response = await _dio.get('$baseUrl/recipes.json');
      if (response.data != null) {
        final recipesData = Map<String, dynamic>.from(response.data);
        final recipesList = recipesData.entries.map((entry) {
          final recipeJson = entry.value as Map<String, dynamic>;
          return Recipe.fromJson(recipeJson);
        }).toList();
        return recipesList;
      } else {
        return null;
      }
    } on DioException catch (e) {
      throw e.response!.data;
    } catch (e) {
      rethrow;
    }
  }
}
