import 'package:flutter/material.dart';
import 'package:flutter_application/ui/views/screens/home_screen/home_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  List screens = [
    HomeScreen(),
    Center(
      child: Text("Explre Screen"),
    ),
    Center(
      child: Text("Add Screen"),
    ),
    Center(
      child: Text("Smth Screen"),
    ),
    Center(
      child: Text("Profile Screen"),
    )
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndex =
                value; // Update currentIndex with the tapped item index
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              size: 56,
              color: Colors.orange,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        currentIndex: currentIndex, // Set currentIndex here
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
      body: screens[currentIndex],
    );
  }
}
