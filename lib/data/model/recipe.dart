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
  List<String> likes;
  List<int> rate;
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
      'estimatedTime': estimatedTime.inMinutes,
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
      ingredient: (json['ingredient'] as List<dynamic>?)
              ?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      description: json['description'],
      preparation: List<String>.from(json['preparation'] ?? []),
      estimatedTime: Duration(minutes:  json['estimatedTime']),
      category: List<String>.from(json['category']),
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'] ??
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      userId: json['userId'],
      id: json['id'],
      isSaved: json['isSaved'] ?? false,
      likes: List<String>.from(json['likes'] ?? []),
      rate: List<int>.from(json['rate']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  static Duration parseDuration(String s) {
    List<String> parts = s.split(':');
    if (parts.length != 3) {
      throw const FormatException('Invalid time string format');
    }
    List<String> secondsParts = parts[2].split('.');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(secondsParts[0]);
    int microseconds = int.parse(secondsParts[1]);
    return Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      microseconds: microseconds,
    );
  }

  factory Recipe.copy() {
    return Recipe(
      title: '',
      ingredient: [],
      description: '',
      preparation: [],
      estimatedTime: const Duration(minutes: 0),
      category: [],
      comments: [],
      imageUrl: '',
      videoUrl: '',
      userId: '',
      id: '',
      isSaved: false,
      likes: ['9SjFRAq9AJSIqIshJmFA1kAHtjr1'],
      rate: [4, 5, 2],
      createdAt: DateTime.now(),
    );
  }
}
