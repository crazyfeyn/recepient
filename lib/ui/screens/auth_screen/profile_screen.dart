import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/user_model.dart';
import 'package:flutter_application/data/services/user/firebase_user_service.dart';
import 'package:flutter_application/logic/bloc/auth/auth_bloc.dart';
import 'package:flutter_application/logic/bloc/auth/auth_event.dart';
import 'package:flutter_application/logic/bloc/auth/auth_state.dart';
import 'package:flutter_application/ui/screens/profiles_screen/edit_screen.dart';
import 'package:flutter_application/ui/screens/profiles_screen/settings_screen.dart';
import 'package:flutter_application/ui/screens/splash_screens/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user;
  String? uId;
  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserInfo();
  }

  Future<void> getCurrentUserInfo() async {
    try {
      uId = await FirebaseUserService.getId();
      if (uId != null) {
        user = await FirebaseUserService().getUser(uId!);
      }
      setState(() {});
    } catch (e) {
      print('Error fetching user info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.person,
          ),
        ),
        title: const Text('Profile Screen'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return WelcomeScreen();
                },
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'My Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : user?.imageUrl != null
                                ? NetworkImage(user!.imageUrl)
                                : const AssetImage('assets/images/malfoy.png')
                                    as ImageProvider,
                        backgroundColor: Colors.grey.shade200,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        user?.name ?? 'Malfoy',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  icon: CupertinoIcons.settings,
                  title: "Settings",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SettingsScreen();
                        },
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.person,
                  title: "Edit Profile",
                  onTap: () async {
                    final response = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(),
                      ),
                    );
                    if (response != null) {
                      setState(() {
                        user!.imageUrl = response['image'];
                        user!.name = response['name'];
                      });
                    }
                  },
                ),
                _buildMenuItem(
                  icon: Icons.logout,
                  title: "Logout",
                  onTap: () {
                    context.read<AuthBloc>().add(LogoutEvent());
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_outlined),
      ),
    );
  }
}
