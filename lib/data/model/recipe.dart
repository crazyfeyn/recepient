import 'package:flutter_application/data/model/comment.dart';
import 'package:flutter_application/data/model/ingredient.dart';

class Recipe {
  String title;
  List<Ingredient> ingredient;
  String description;
  List<String> preparation;
  Duration estimatedTime;
  List<String> category;
  String imageUrl;
  String videoUrl;
  String userId;
  String id;
  bool isSaved;
  int likes;
  double rate;
  List<Comment> comments;
  DateTime createdAt;

  Recipe({
    required this.title,
    required this.ingredient,
    required this.description,
    required this.preparation,
    required this.estimatedTime,
    required this.category,
    required this.imageUrl,
    required this.videoUrl,
    required this.userId,
    required this.id,
    required this.isSaved,
    required this.likes,
    required this.rate,
    required this.comments,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'ingredient': ingredient.map((e) => e.toJson()).toList(),
      'description': description,
      'preparation': preparation,
      'estimatedTime': estimatedTime.inMilliseconds,
      'category': category,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'userId': userId,
      'id': id,
      'isSaved': isSaved,
      'likes': likes,
      'rate': rate,
      'comments': comments.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'],
      ingredient: (json['ingredient'] as Map<String, dynamic>)
          .entries
          .map((entry) => Ingredient.fromJson(entry.value))
          .toList(),
      description: json['description'],
      preparation: List<String>.from(json['preparation']),
      estimatedTime: Duration(
        hours: int.parse(json['estimatedTime'].split(':')[0]),
        minutes: int.parse(json['estimatedTime'].split(':')[1]),
        seconds: int.parse(json['estimatedTime'].split(':')[2].split('.')[0]),
        microseconds: int.parse(json['estimatedTime'].split('.')[1]),
      ),
      category: List<String>.from(json['category']),
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      userId: json['userId'],
      id: json['id'],
      isSaved: json['isSaved'],
      likes: json['likes'],
      rate: double.parse(json['rate'].toString()),
      comments: (json['comments'] as Map<String, dynamic>)
          .entries
          .map((entry) => Comment.fromJson(entry.value))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
