import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        title: Text("Settings screen"),
      ),
      body: Padding(padding: EdgeInsets.all(20),child: Column(
        children: [
            ZoomTapAnimation(
                onTap: () {
                  _showModalBottomSheetForMode(context);
                },
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.dark_mode_outlined,
                    size: 40,
                  ),
                  title: Text(
                  'Cahnge mode',
                    style: const TextStyle(fontSize: 20),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              SizedBox(height: 20,),
              ZoomTapAnimation(
                onTap: () {
                  _showModalBottomSheet(context);
                },
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.language,
                    size: 40,
                  ),
                  title: Text(
                   'Language',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),

        ],
      ),),
    );
  }
}
