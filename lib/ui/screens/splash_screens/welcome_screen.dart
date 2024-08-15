import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application/logic/bloc/auth/auth_event.dart';
import 'package:flutter_application/ui/screens/auth_screen/login_screen.dart';
import 'package:flutter_application/ui/screens/splash_screens/first_onboarding_screen.dart';
import 'package:flutter_application/ui/screens/all_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/logic/bloc/auth/auth_bloc.dart';
import 'package:flutter_application/logic/bloc/auth/auth_state.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(AppStartedEvent());
    });
  }

  void _navigateBasedOnState(AuthState state) {
    if (state is AuthAuthenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AllNavigationBar()),
      );
    } else if (state is AuthUnauthenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FirstOnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // Navigate based on the authentication state after the delay
          Future.delayed(const Duration(seconds: 2), () {
            _navigateBasedOnState(state);
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.orange.shade300,
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/splash/image.png',
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/splash/logo.png',
                width: 150,
                height: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
