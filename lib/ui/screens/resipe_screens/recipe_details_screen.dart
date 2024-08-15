import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/recipe.dart';
import 'package:flutter_application/data/services/recipes/firebase_recipe_service.dart';
import 'package:flutter_application/ui/widgets/recipe_widgets/ingredients_section_widget.dart';
import 'package:flutter_application/ui/widgets/recipe_widgets/recipe_step_card.dart';
import 'package:flutter_application/ui/widgets/recipe_widgets/review_page_widget.dart';
import 'package:flutter_application/ui/widgets/recipe_widgets/video_and_action_widget.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';

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
  int _currentIndex = 0;

  late VideoPlayerController _controller;
  final String videoUrl =
      "https://sample-videos.com/video321/mp4/240/big_buck_bunny_240p_30mb.mp4";

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl),
    )..initialize().then((_) {
        setState(() {});
      });
  }

// Sana formatlash funksiyasi
  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(date);
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
            Container(
              width: size,
              height: 262,
              decoration: BoxDecoration(
                color: Colors.amber,
                image: DecorationImage(
                  image: NetworkImage(widget.recipe!.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Row(
                children: [
                  Text(
                    widget.recipe!.title,
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
                          FirebaseRecipeService.calculateRating(
                                  widget.recipe!.rate)
                              .toStringAsFixed(1),
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
                    formatDate(widget.recipe!.createdAt),
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
                    "${widget.recipe!.estimatedTime.inMinutes.toString()}Min",
                    style: GoogleFonts.montserrat(fontSize: 12),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Row(
                children:
                    List.generate(widget.recipe!.category.length, (index) {
                  final category = widget.recipe!.category[index];

                  return Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: GoogleFonts.montserrat(
                          color: Colors.orange,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Text(
                "Ingredients",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            IngredientsSectionWidget(recipe: widget.recipe),
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
            RecipeStepCard(size: size, recipe: widget.recipe),
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
            ReviewPageWidget(recipe: widget.recipe),
          ],
        ),
      ),
    );
  }
}
