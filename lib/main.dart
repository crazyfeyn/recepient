import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/controllers/recipe_add_controller.dart';
import 'package:flutter_application/data/repositories/auth_repository.dart';
import 'package:flutter_application/data/services/user/firebase_user_service.dart';
import 'package:flutter_application/firebase_options.dart';
import 'package:flutter_application/logic/bloc/auth/auth_bloc.dart';
import 'package:flutter_application/logic/bloc/auth/auth_event.dart';
import 'package:flutter_application/logic/bloc/home/home_bloc.dart';
import 'package:flutter_application/logic/cubits/home_screen_cubits.dart';
import 'package:flutter_application/ui/screens/navigationbar_screen/all_navigation_bar.dart';
import 'package:flutter_application/ui/screens/splash_screens/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
    final FirebaseUserService firebaseUserService = FirebaseUserService();
    return RepositoryProvider(
      create: (context) => AuthRepository(authService: FirebaseAuthSerivce()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return AuthBloc(
                authRepository: context.read<AuthRepository>(),
                firebaseUserService: firebaseUserService,
              );
            },
          ),
          BlocProvider(create: (context) {
            return HomeScreenCubits();
          }),
          BlocProvider(create: (context) {
            return HomeBloc();
          })
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AllNavigationBar(),
        ),
      ),
    );
  }
}
