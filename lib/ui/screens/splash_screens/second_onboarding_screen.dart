import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/ui/screens/auth_screen/login_screen.dart';
import 'package:flutter_application/ui/screens/splash_screens/third_onboarding_screen.dart';
import 'package:flutter_application/ui/widgets/eleveted_button.dart';

class SecondOnboardingScreen extends StatelessWidget {
  const SecondOnboardingScreen({super.key});

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
                '1.Browse thousands of recipe',
                style: TextStyle(color: Colors.orange, fontSize: 20),
              ),
              Image.asset(
                'assets/images/splash/second.png',
              ),
              const Spacer(),
              ElevetedButtonWidget(
                color: Colors.orange,
                title: 'Next',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const ThirdOnboardingScreen();
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
