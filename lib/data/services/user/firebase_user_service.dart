import 'package:dio/dio.dart';
import 'package:flutter_application/data/model/user_model.dart';

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
    // ignore: empty_catches
    } catch (e) {}
  }

  Future<UserModel?> getUser(String uId) async {
    try {
      final response = await _dio.get('$baseUrl/users/$uId.json');
      if (response.data != null) {
        return UserModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      // ignore: unused_local_variable
      final response = await _dio.patch(
        '$baseUrl/users/${user.uId}.json',
        data: user.toJson(),
      );
    // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> deleteUser(String uId) async {
    try {
      // ignore: unused_local_variable
      final response = await _dio.delete('$baseUrl/users/$uId.json');
    // ignore: empty_catches
    } catch (e) {}
  }
}
