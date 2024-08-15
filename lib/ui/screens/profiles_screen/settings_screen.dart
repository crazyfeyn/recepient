import 'package:flutter/material.dart';
import 'package:flutter_application/ui/widgets/modalshet_forLang.dart';
import 'package:flutter_application/ui/widgets/modalshet_forMode.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  void _showModalBottomSheetForMode(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const Bottomformode();
      },
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const Bottomforlang();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ZoomTapAnimation(
              onTap: () {
                _showModalBottomSheetForMode(context);
              },
              child: const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.dark_mode_outlined,
                  size: 40,
                ),
                title: Text(
                  'Change mode',
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ZoomTapAnimation(
              onTap: () {
                _showModalBottomSheet(context);
              },
              child: const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.language,
                  size: 40,
                ),
                title: Text(
                  'Language',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
