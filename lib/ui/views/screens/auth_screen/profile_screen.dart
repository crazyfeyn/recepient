import 'package:flutter/material.dart';
import 'package:flutter_application/logic/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('qwerty'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogoutEvent());
            },
            icon: Icon(
              Icons.logout,
            ),
          )
        ],
      ),
    );
  }
}
