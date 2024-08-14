import 'package:dio/dio.dart';
import 'package:flutter_application/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseUserService {
  final Dio _dio = Dio();
  String uId = '';
  final String baseUrl =
      'https://retsept-app-db287-default-rtdb.firebaseio.com/';

  Future<void> createUser(UserModel user) async {
    try {
      final response = await _dio.put(
        '$baseUrl/users/${user.uId}.json',
        data: user.toJson(),
      );
      print(response.data['name']);
      uId = response.data['uId'];
      final shared = await SharedPreferences.getInstance();
      shared.setString('id', uId);
      print('User createdwsedrfghgtredrfgrfvdrfc: ${uId}');
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  Future<UserModel?> getUser(String uId) async {
    try {
      final response = await _dio.get('$baseUrl/users/$uId.json');
      if (response.data != null) {
        return UserModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      final response = await _dio.patch(
        '$baseUrl/users/${user.uId}.json',
        data: user.toJson(),
      );
      print('User updated: ${response.data}');
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  static  getId() async {
    final shared = await SharedPreferences.getInstance();
    String? id = shared.getString('id');
    return id;
  }
}
