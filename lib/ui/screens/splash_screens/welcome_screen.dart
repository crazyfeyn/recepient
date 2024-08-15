import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/services/user/firebase_user_service.dart';
import 'package:flutter_application/data/utils/app_constants.dart';
import 'package:flutter_application/ui/screens/navigationbar_screen/all_navigation_bar.dart';
import 'package:flutter_application/ui/screens/splash_screens/first_onboarding_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    checkingIdStatus();
  }

  Future<void> checkingIdStatus() async {
    final x = await FirebaseUserService.getId();
    print(x);
    Timer(Duration(seconds: 2), () {
      if (AppConstants.uId.isNotEmpty) {
        print('success');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AllNavigationBar()),
        );
      } else {
        print('fail');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const FirstOnboardingScreen()),
        );
      }
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
            image: AssetImage('assets/images/splash/image.png'),
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
