import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/controllers/recipe_add_controller.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<String> recipeCategories = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Asian',
    'European',
    'Desserts',
    'Snacks',
    'Vegan',
    'Salads',
  ];

  List<String> selectedCategories = [];

  void _onContinuePressed() {
    final recipeAddController = context.read<RecipeAddController>();
    if (selectedCategories.isNotEmpty) {
      recipeAddController.addCotegoriys(selectedCategories);
      recipeAddController.pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Categories',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: recipeCategories.length,
              itemBuilder: (context, index) {
                bool isSelected =
                    selectedCategories.contains(recipeCategories[index]);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedCategories.remove(recipeCategories[index]);
                      } else {
                        selectedCategories.add(recipeCategories[index]);
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color:
                              isSelected ? Colors.blue : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      recipeCategories[index],
                      style: TextStyle(
                        fontSize: 20,
                        color: isSelected
                            ? Colors.blue
                            : AdaptiveTheme.of(context).mode ==
                                    AdaptiveThemeMode.light
                                ? Colors.black
                                : Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: _onContinuePressed,
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.orange,
              ),
              child: const Text(
                "Continue",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
