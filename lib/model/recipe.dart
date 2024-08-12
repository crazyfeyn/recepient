import 'package:flutter_application/model/comment.dart';
import 'package:flutter_application/model/ingredient.dart';

class Recipe {
  String title;
  Ingredient ingredient;
  String description;
  List<String> preparation;
  DateTime datetime;
  List<String> category;
  String imageUrl;
  String videoUrl;
  String userId;
  String id;
  bool isSaved;
  int likes;
  double rate;
  List<Comment> comments;

  Recipe({
    required this.title,
    required this.ingredient,
    required this.description,
    required this.preparation,
    required this.datetime,
    required this.category,
    required this.imageUrl,
    required this.videoUrl,
    required this.userId, 
    required this.id, 
    required this.isSaved,
    required this.likes,
    required this.rate,
    required this.comments
  });
}
