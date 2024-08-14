import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/controllers/recipe_add_controller.dart';
import 'package:flutter_application/data/model/recipe.dart';
import 'package:provider/provider.dart';

class ReviewWidget extends StatefulWidget {
  ReviewWidget({super.key});

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  late Recipe recipe;

  _onContinuePressed() {}

  @override
  Widget build(BuildContext context) {
    final recipeAddController = context.read<RecipeAddController>();
    recipe = recipeAddController.recipe;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Receipe Name',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                  Text(
                    recipe.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const Text(
                    'Estimade Time',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                  Text(
                    '${recipe.estimatedTime.inMinutes} minutes',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: _onContinuePressed,
              child: Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: const Color(0xffFF9B05),
                ),
                child: const Text(
                  "Finsh",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
