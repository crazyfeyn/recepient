import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/recipe.dart';
import 'package:flutter_application/ui/widgets/recipe_details_widgets/ingredients_section_widget.dart';
import 'package:flutter_application/ui/widgets/recipe_details_widgets/recipe_step_card.dart';
import 'package:flutter_application/ui/widgets/recipe_details_widgets/review_page_widget.dart';
import 'package:flutter_application/ui/widgets/recipe_details_widgets/video_and_action_widget.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final Recipe? recipe;
  const RecipeDetailsScreen({
    super.key,
    this.recipe,
  });

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  final List<String> _imageUrls = [
    "https://amiel.club/uploads/posts/2022-03/thumbs/1647740928_29-amiel-club-p-kartinki-salat-32.jpg",
    "https://i.pinimg.com/originals/0e/ed/c9/0eedc9e9a5104635d84d3b06b3e162b5.jpg",
    "https://avatars.mds.yandex.net/i?id=309e6015d9c292be9692516ec5801202_l-5450418-images-thumbs&n=13",
  ];

  int _currentIndex = 0;
  bool isExpanded1 = false;
  bool isExpanded2 = false;

  void _nextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _imageUrls.length;
    });
  }

  late VideoPlayerController _controller;
  final String videoUrl =
      "https://sample-videos.com/video321/mp4/240/big_buck_bunny_240p_30mb.mp4";

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl),
    )..initialize().then((_) {
        print("INITIALIZED");
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: size,
                  height: 262,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(_imageUrls[_currentIndex]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 80,
                  right: 10,
                  child: IconButton(
                    onPressed: _nextImage,
                    icon: const Icon(
                      Icons.arrow_circle_right,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: (size / 2) - 60 / 2,
                  child: Row(
                    children: List.generate(_imageUrls.length, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 13,
                        height: 13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _currentIndex == index
                              ? Colors.white
                              : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Row(
                children: [
                  Text(
                    "Sausage Nasi Goreng ",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          size: 15,
                          color: Colors.amber,
                        ),
                        Text(
                          "4.9",
                          style: GoogleFonts.montserrat(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 5),
              child: Row(
                children: [
                  Text(
                    "21 May 2024",
                    style: GoogleFonts.montserrat(fontSize: 12),
                  ),
                  const Gap(10),
                  const Icon(
                    Icons.watch_later,
                    color: Colors.grey,
                    size: 20,
                  ),
                  const Gap(5),
                  Text(
                    "30 Minutes",
                    style: GoogleFonts.montserrat(fontSize: 12),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 20),
              child: Row(
                children: [
                  Container(
                    width: 55,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Asian",
                        style: GoogleFonts.montserrat(
                          color: Colors.orange,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Container(
                    width: 90,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Indonesian",
                        style: GoogleFonts.montserrat(
                          color: Colors.orange,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Container(
                    width: 50,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Rice",
                        style: GoogleFonts.montserrat(
                          color: Colors.orange,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Container(
                    width: 70,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Oriental",
                        style: GoogleFonts.montserrat(
                          color: Colors.orange,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 30),
              child: Text(
                "Ingredients",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            const IngredientsSectionWidget(),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 30),
              child: Text(
                "How-to",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            RecipeStepCard(size: size),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 30, bottom: 10),
              child: Text(
                "How-to Videos",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            VideoAndActionWidget(controller: _controller, size: size),
            const Gap(10),
            const Divider(indent: 20, endIndent: 20),
            const Gap(10),
            const ReviewPageWidget(),
          ],
        ),
      ),
    );
  }
}
