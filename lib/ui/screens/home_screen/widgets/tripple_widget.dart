import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/recipe.dart';
import 'package:flutter_application/data/services/recipes/firebase_recipe_service.dart';
import 'package:flutter_application/data/utils/app_constants.dart';
import 'package:flutter_application/ui/screens/home_screen/widgets/build_recipe_card_widget.dart';
import 'package:flutter_application/ui/screens/home_screen/widgets/build_user_greeting_widget.dart';
import 'package:flutter_svg/svg.dart';
import '../../resipe_screens/recipe_details_screen.dart';

class TrippleWidget extends StatefulWidget {
  final List<Recipe> recipes;
  const TrippleWidget({super.key, required this.recipes});

  @override
  State<TrippleWidget> createState() => _TrippleWidgetState();
}

class _TrippleWidgetState extends State<TrippleWidget> {
  late List<Recipe> _filteredRecipes;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredRecipes = widget.recipes;
  }

  List<String> categories = [
    'All',
    'Latest',
    'Trending',
  ];

  int _selectedIndex = 0;

  void _onCategoryTap(int index) {
    _selectedIndex = index;
    _filteredRecipes = widget.recipes;
    switch (index) {
      case 0:
        _filteredRecipes = widget.recipes;
        break;
      case 1:
        _filteredRecipes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      case 2:
        _filteredRecipes.sort((a, b) =>
            FirebaseRecipeService.calculateRating(b.rate)
                .compareTo(FirebaseRecipeService.calculateRating(a.rate)));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildUserGreetingWidget(
          user: AppConstants.userModel,
        ),
        const SizedBox(height: 20),
        _buildSearchBar(),
        const SizedBox(height: 20),
        SizedBox(
          height: 46,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(categories.length, (index) {
                return GestureDetector(
                  onTap: () => _onCategoryTap(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xFFC1C1C1)),
                      color: _selectedIndex == index
                          ? const Color(0xFFFF9B05)
                          : Colors.white,
                    ),
                    width: 100,
                    height: 46,
                    alignment: Alignment.center,
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: index == _selectedIndex
                            ? Colors.white
                            : Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'All recipes',
          style: TextStyle(
            color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ||
                    AdaptiveTheme.of(context).mode == AdaptiveThemeMode.system
                ? Colors.black
                : Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 19,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredRecipes.length,
            itemBuilder: (context, index) {
              final recipe = _filteredRecipes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailsScreen(recipe: recipe),
                    ),
                  );
                },
                child: BuildRecipeCardWidget(recipe: recipe),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      onChanged: (query) {
        _searchRecipes(query);
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        labelText: 'Search recipes',
        suffixIcon: Container(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            'assets/svg/search_icon.svg',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  void _searchRecipes(String query) {
    if (query.isEmpty) {
      _filteredRecipes = widget.recipes;
    } else {
      _filteredRecipes = widget.recipes.where((recipe) {
        return recipe.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    setState(() {});
  }
}
