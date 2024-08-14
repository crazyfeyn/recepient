import 'package:flutter/material.dart';
import 'package:flutter_application/ui/views/screens/auth_screen/login_screen.dart';
import 'package:flutter_application/ui/views/widgets/eleveted_button.dart';

class FourtOnboardingScreen extends StatelessWidget {
  const FourtOnboardingScreen({super.key});

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
                '4.Share with friends!',
                style: TextStyle(color: Colors.orange, fontSize: 20),
              ),
              Image.asset(
                'assets/images/splash/fourt.png',
              ),
              const SizedBox(
                height: 20,
              ),
              ElevetedButtonWidget(
                color: Colors.orange,
                title: 'Continue',
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

