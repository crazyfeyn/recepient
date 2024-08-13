

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application/data/services/firebase/firebase_auth_serivce.dart';


class AuthRepository {
  final FirebaseAuthSerivce _firebaseAuthSerivce;
  AuthRepository({required FirebaseAuthSerivce firebaseAuthService})
      : _firebaseAuthSerivce = firebaseAuthService;

  Future<void> login({required String email, required String password}) async =>
      await _firebaseAuthSerivce.loginUser(email: email, password: password);

  Future<void> register(
          {required String email, required String password,required String name}) async =>
      await _firebaseAuthSerivce.registerUser(email: email, password: password,name:name);

  Future<void> logOut() async => await _firebaseAuthSerivce.logOutUser();

  Future<void> resetPassword({required String email}) async =>
      await _firebaseAuthSerivce.resetPassword(email: email);

  Stream<User?> watchAuth() => _firebaseAuthSerivce.watchAuth();

  User? get currentUser => _firebaseAuthSerivce.currentUser;
}
