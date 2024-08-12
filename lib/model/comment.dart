import 'package:flutter_application/model/user.dart';

class Comment {
  int rate;
  UserModel user;
  String title;

  Comment({required this.rate, required this.user, required this.title});
}
