import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/repositories/auth_repository.dart';
import 'package:flutter_application/data/services/firebase/firebase_auth_serivce.dart';
import 'package:flutter_application/firebase_options.dart';
import 'package:flutter_application/logic/bloc/auth/auth_bloc.dart';
import 'package:flutter_application/logic/cubits/home_screen_cubits.dart';
import 'package:flutter_application/ui/recipe_details_screen.dart';
import 'package:flutter_application/ui/screens/splash_screens/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) =>
          AuthRepository(firebaseAuthService: FirebaseAuthSerivce()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return AuthBloc(authRepository: context.read<AuthRepository>());
            },
          ),
          BlocProvider(create: (context) {
            return HomeScreenCubits();
          })
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, user) {
              if (user.hasData) {
                return const WelcomeScreen();
              } else {
                return const RecipeDetailsScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
