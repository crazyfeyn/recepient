import 'package:flutter/material.dart';
import 'package:flutter_application/ui/screens/auth_screen/login_screen.dart';
import 'package:flutter_application/ui/screens/splash_screens/fourt_onboarding_screen.dart';
import 'package:flutter_application/ui/widgets/eleveted_button.dart';

class ThirdOnboardingScreen extends StatelessWidget {
  const ThirdOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What`s inside',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1.5,
              ),
              const Text(
                '2.Personalized your feed',
                style: TextStyle(color: Colors.orange, fontSize: 20),
              ),
              Image.asset(
                'assets/images/splash/third.png',
              ),
              ElevetedButtonWidget(
                color: Colors.orange,
                title: 'Next',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const FourtOnboardingScreen();
                      },
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevetedButtonWidget(
                color: Colors.white,
                title: 'Skip',
                textColor: Colors.black,
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
