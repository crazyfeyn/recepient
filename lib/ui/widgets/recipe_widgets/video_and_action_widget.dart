import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/ui/screens/resipe_screens/my_resipes_screen.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class VideoAndActionWidget extends StatefulWidget {
  final VideoPlayerController controller;
  final double size;

  const VideoAndActionWidget({
    super.key,
    required this.controller,
    required this.size,
  });

  @override
  _VideoAndActionWidgetState createState() => _VideoAndActionWidgetState();
}

class _VideoAndActionWidgetState extends State<VideoAndActionWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  Future<void> _saveVideoUrl(String videoUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_video', videoUrl);
  }

  void _showBottomDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 50),
            const SizedBox(height: 10),
            Text(
              "Recipe added to My Recipes!",
              style: GoogleFonts.montserrat(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  void _addToMyRecipes() async{
    await _saveVideoUrl("https://sample-videos.com/video321/mp4/240/big_buck_bunny_240p_30mb.mp4");
    _showBottomDialog();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(context, CupertinoPageRoute(builder: (ctx) {
        return const MyResipesScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: widget.size * 0.93,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  if (_controller.value.isInitialized) VideoPlayer(_controller),
                  Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 50,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: widget.size * 0.9,
              height: 50,
              child: ElevatedButton(
                onPressed: _addToMyRecipes, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Add to My Recipes",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: widget.size * 0.9,
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.download,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Download Recipe",
                      style: GoogleFonts.montserrat(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
