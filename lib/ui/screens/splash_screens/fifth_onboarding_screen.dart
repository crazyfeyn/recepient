import 'package:flutter/material.dart';
import 'package:flutter_application/ui/widgets/eleveted_button.dart';

class FifthOnboardingScreen extends StatelessWidget {
  const FifthOnboardingScreen({super.key});

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
                '3.Save your favorite recipe',
                style: TextStyle(color: Colors.orange, fontSize: 20),
              ),
              Image.asset(
                'assets/images/splash/fifth.png',
              ),
              const SizedBox(
                height: 20,
              ),
              ElevetedButtonWidget(
                color: Colors.orange,
                title: 'Next',
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return FifthOnboardingScreen();
                  //     },
                  //   ),
                  // );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevetedButtonWidget(
                color: Colors.white,
                title: 'Skip',
                textColor: Colors.black,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
