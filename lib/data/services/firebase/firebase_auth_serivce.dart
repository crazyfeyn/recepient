import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application/data/model/user_model.dart';
import 'package:flutter_application/data/services/user/firebase_user_service.dart';

class FirebaseAuthSerivce {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
   final FirebaseUserService _firebaseUserService = FirebaseUserService();
  Future<void> loginUser(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      throw (e.message.toString());
    } catch (e) {
      rethrow;
    }
  }

   Future<User> registerUser({
    required String email,
    required String password,
    required String name,
     String? imageUrl,
  }) async {
    try {
      
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = response.user!;

    
      UserModel newUser = UserModel(
        email: user.email!,
        name: name,
        imageUrl: '',
        uId: user.uid,
        likes: [],
        saved: [],
      );

      // Save the user to Firebase Realtime Database
      await _firebaseUserService.createUser(newUser);

      return user;
    } on FirebaseException catch (e) {
      throw (e.message.toString());
    } catch (e) {
      rethrow;
    }
  }
  Future<void> logOutUser() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseException catch (e) {
      throw (e.message.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (e) {
      throw (e.message.toString());
    } catch (e) {
      rethrow;
    }
  }

  Stream<User?> watchAuth() => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;
}
