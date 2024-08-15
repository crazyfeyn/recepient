import 'package:dio/dio.dart';
import 'package:flutter_application/data/model/user_model.dart';
import 'package:flutter_application/data/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseUserService {
  final Dio _dio = Dio();
  final String baseUrl =
      'https://retsept-app-db287-default-rtdb.firebaseio.com/';

  Future<void> createUser(UserModel user) async {
    try {
      // ignore: unused_local_variable
      final response = await _dio.put(
        '$baseUrl/users/${user.uId}.json',
        data: user.toJson(),
      );
      final shared = await SharedPreferences.getInstance();
      shared.setString('id', user.uId);
    } catch (e) {
      throw Exception('Error creating user: $e');
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
      throw Exception('Error fetching user: $e');
    }
  }

  Future<void> updateUserNameAndPhoto(String name, String imageUrl) async {
    try {
      // ignore: unused_local_variable
      final response = await _dio.patch(
        '$baseUrl/users/${AppConstants.uId}.json',
        data: {
          'name': name,
          'imageUrl': imageUrl,
        },
      );
    // ignore: empty_catches
    } catch (e) {
      
    }
  }

  static Future<String?> getId() async {
    final shared = await SharedPreferences.getInstance();
    return shared.getString('id');
  }

  static Future<void> clearUserData() async {
    final shared = await SharedPreferences.getInstance();
    await shared.clear();
  }
}
