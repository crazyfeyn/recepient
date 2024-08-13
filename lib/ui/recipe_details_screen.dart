import 'package:flutter/material.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({super.key});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: size,
                height: 262,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://amiel.club/uploads/posts/2022-03/thumbs/1647740928_29-amiel-club-p-kartinki-salat-32.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 131,
                top: 110,
                right: 10,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_circle_right,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
              Container(
                width: 60,
                height: 13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
