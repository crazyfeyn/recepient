import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class MyResipesScreen extends StatefulWidget {
  const MyResipesScreen({super.key});

  @override
  State<MyResipesScreen> createState() => _MyResipesScreenState();
}

class _MyResipesScreenState extends State<MyResipesScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late VideoPlayerController _videoController;
  bool _isVideoLoaded = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _loadVideo();
  }

  @override
  void dispose() {
    tabController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  Future<void> _loadVideo() async {
    final prefs = await SharedPreferences.getInstance();
    final videoUrl = prefs.getString('saved_video');

    if (videoUrl != null) {
      _videoController = VideoPlayerController.asset(videoUrl)
        ..initialize().then((_) {
          setState(() {
            _isVideoLoaded = true;
          });
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Recipes"),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(text: "Uploaded"),
            Tab(text: "Saved Recipes"),
          ],
          indicatorColor: Colors.amber,
          labelColor: Colors.amber,
          unselectedLabelColor: Colors.black,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          const Center(
            child: Text("Uploaded Recipes Content"),
          ),
          _isVideoLoaded
              ? Center(
                  child: AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(_videoController),
                  ),
                )
              : const Center(
                  child: Text("No saved recipes"),
                ),
        ],
      ),
    );
  }
}
