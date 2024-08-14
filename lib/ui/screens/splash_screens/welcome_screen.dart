import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/services/user/firebase_user_service.dart';
import 'package:flutter_application/data/utils/app_constants.dart';
import 'package:flutter_application/ui/screens/splash_screens/first_onboarding_screen.dart';
import 'package:flutter_application/ui/screens/all_navigation_bar.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    // Get the user ID and store it in AppConstants
    FirebaseUserService.getId().then((id) {
      AppConstants.uId = id;

      // After the splash screen duration, check if user is authenticated
      Timer(const Duration(seconds: 2), () {
        if (id != null && id.isNotEmpty) {
          // Navigate to the main app if authenticated
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AllNavigationBar()),
          );
        } else {
          // Navigate to the onboarding screen if not authenticated
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const FirstOnboardingScreen()),
          );
        }
      });
    }).catchError((error) {
      print("Failed to get user ID: $error");
      // You may handle error by redirecting to a specific screen if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
    );
  }
}
