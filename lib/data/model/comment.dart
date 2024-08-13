import 'package:flutter_application/data/model/user_model.dart';

class Comment {
  int rate;
  UserModel user;
  String title;

  Comment({required this.rate, required this.user, required this.title});
}
