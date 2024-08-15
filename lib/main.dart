import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/controllers/recipe_add_controller.dart';
import 'package:flutter_application/data/repositories/auth_repository.dart';
import 'package:flutter_application/data/services/user/firebase_user_service.dart';
import 'package:flutter_application/firebase_options.dart';
import 'package:flutter_application/logic/bloc/auth/auth_bloc.dart';
import 'package:flutter_application/logic/bloc/home/home_bloc.dart';
import 'package:flutter_application/logic/bloc/user-update/user_update_bloc.dart';
import 'package:flutter_application/logic/cubits/home_screen_cubits.dart';
import 'package:flutter_application/ui/screens/splash_screens/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('es')],
      path: 'resources/langs',
      fallbackLocale: const Locale('en'),
      child: MyApp(savedThemeMode: savedThemeMode),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    final firebaseUserService = FirebaseUserService();

    return RepositoryProvider(
      create: (context) => AuthRepository(authService: FirebaseAuthSerivce()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
              firebaseUserService: firebaseUserService,
            ),
          ),
          BlocProvider(create: (context) => HomeScreenCubits()),
          BlocProvider(create: (context) => HomeBloc()),
          BlocProvider(
            create: (context) => UpdateUserBloc(
              firebaseUserService: firebaseUserService,
            ),
          ),
          ChangeNotifierProvider<RecipeAddController>(
            create: (_) => RecipeAddController(),
          ),
        ],
        child: AdaptiveTheme(
          light: ThemeData.light(),
          dark: ThemeData.dark(),
          initial: savedThemeMode ?? AdaptiveThemeMode.system,
          builder: (theme, darkTheme) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            darkTheme: darkTheme,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            home: const WelcomeScreen(),
          ),
        ),
      ),
    );
  }
}
