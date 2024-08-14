import 'package:dio/dio.dart';
import 'package:flutter_application/data/model/user_model.dart';

class FirebaseUserService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://retsept-app-db287-default-rtdb.firebaseio.com/';

  Future<void> createUser(UserModel user) async {
    try {
      final response = await _dio.put(
        '$baseUrl/users/${user.uId}.json',
        data: user.toJson(),
      );
      print('User created: ${response.data}');
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

  Future<void> deleteUser(String uId) async {
    try {
      final response = await _dio.delete('$baseUrl/users/$uId.json');
      print('User deleted: ${response.data}');
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}
