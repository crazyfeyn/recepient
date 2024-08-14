import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class FirebaseAuthSerivce {
  final String _apiKey = 'AIzaSyDDGJsVvy7szTGa8U1EhxZwY58zX9Y9wh4';
  Dio _dio = Dio();

  Future<Map<String, dynamic>> authenticate(
    String email,
    String password,
    String action,
  ) async {
    print(email);
    print(password);
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$action?key=$_apiKey';
    try {
      final response = await _dio.post(
        url,
        data: {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      );

      return response.data;
    } on DioException catch (e) {
      log(e.toString());
      if (e.response != null) {
        final data = e.response?.data;
        final errorMessage = data != null && data['error'] != null
            ? data['error']['message']
            : 'An unexpected error occurred';
        print('Dio Error: $errorMessage');
        throw (errorMessage);
      } else {
        print('Dio Error: ${e.message}');
        throw ('An unexpected error occurred');
      }
    } catch (e) {
      print('General Error: ${e.toString()}');
      throw ('An error occurred: ${e.toString()}');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=$_apiKey';
    try {
      final response = await _dio.post(
        url,
        data: jsonEncode({
          'requestType': 'PASSWORD_RESET',
          'email': email,
        }),
      );
      print('Response Data: ${response.data}');
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response?.data;
        final errorMessage = data != null && data['error'] != null
            ? data['error']['message']
            : 'An unexpected error occurred';
        print('Dio Error: $errorMessage');
        throw (errorMessage);
      } else {
        print('Dio Error: ${e.message}');
        throw ('An unexpected error occurred');
      }
    } catch (e) {
      print('General Error: ${e.toString()}');
      throw ('An error occurred: ${e.toString()}');
    }
  }
}





//hhj