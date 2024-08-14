import 'package:flutter_application/data/model/user_model.dart';

class Comment {
  int rate;
  String title;
  UserModel user;

  Comment({
    required this.rate,
    required this.title,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'title': title,
      'user': user.toJson(),
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      rate: json['rate'],
      title: json['title'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
