import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // final user = UserModel(
  //     email: 'golibtoramurodov@Gmail.com',
  //     name: 'G\'olibjon',
  //     imageUrl: 'assets/images/malfoy.png',
  //     uId: 'testid1',
  //     likes: [],
  //     saved: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Hello {user.name}',
            style: TextStyle(color: Color(0xFF1E1E1E)),
          ),
        ],
      ),
    );
  }
}
