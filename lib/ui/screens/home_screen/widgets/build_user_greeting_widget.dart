import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/user_model.dart';

// ignore: must_be_immutable
class BuildUserGreetingWidget extends StatelessWidget {
  UserModel? user;
  BuildUserGreetingWidget({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello ${user?.name ?? 'Guest'}',
              style: TextStyle(
                color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                    ? Colors.black
                    : Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 19,
              ),
            ),
            const Text(
              'What are you cooking today?',
              style: TextStyle(
                color: Color(0xFFA9A9A9),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
        Container(
          height: 47,
          width: 47,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: (user?.imageUrl == null || user!.imageUrl.isEmpty)
                  ? const AssetImage('assets/images/malfoy.png')
                      as ImageProvider
                  : NetworkImage(user!.imageUrl) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
