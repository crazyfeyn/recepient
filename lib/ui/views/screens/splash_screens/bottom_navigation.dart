// import 'package:flutter/material.dart';
// import 'package:flutter_application/ui/views/screens/home_screen/home_screen.dart';

// // ignore: use_key_in_widget_constructors
// class BottomNavigationScreen extends StatefulWidget {
//   @override
//   State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
// }

// class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
//   List screens = [
//     const HomeScreen(),
//     const Center(
//       child: Text("Explre Screen"),
//     ),
//     const Center(
//       child: Text("Add Screen"),
//     ),
//     const Center(
//       child: Text("Smth Screen"),
//     ),
//     const Center(
//       child: Text("Profile Screen"),
//     )
//   ];

//   int currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: (value) {
//           setState(() {
//             currentIndex = value;
//           });
//         },
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.explore),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.add_circle,
//               size: 56,
//               color: Colors.orange,
//             ),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.receipt),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: '',
//           ),
//         ],
//         currentIndex: currentIndex, 
//         selectedItemColor: Colors.orange,
//         unselectedItemColor: Colors.grey,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         type: BottomNavigationBarType.fixed,
//       ),
//       body: screens[currentIndex],
//     );
//   }
// }
