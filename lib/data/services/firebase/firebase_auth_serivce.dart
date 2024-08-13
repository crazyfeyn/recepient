// import 'dart:core';

// import 'package:firebase_auth/firebase_auth.dart';

// class FirebaseAuthSerivce {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   Future<void> loginUser(
//       {required String email, required String password}) async {
//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(
//           email: email, password: password);
//     } on FirebaseException catch (e) {
//       throw (e.message.toString());
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<User> registerUser(
//       {required String email, required String password}) async {
//     try {
//       final responce = await _firebaseAuth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       return responce.user!;
//     } on FirebaseException catch (e) {
//       throw (e.message.toString());
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> logOutUser() async {
//     try {
//       await _firebaseAuth.signOut();
//     } on FirebaseException catch (e) {
//       throw (e.message.toString());
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> resetPassword({required String email}) async {
//     try {
//       await _firebaseAuth.sendPasswordResetEmail(email: email);
//     } on FirebaseException catch (e) {
//       throw (e.message.toString());
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Stream<User?> watchAuth() => _firebaseAuth.authStateChanges();

//   User? get currentUser => _firebaseAuth.currentUser;
// }
