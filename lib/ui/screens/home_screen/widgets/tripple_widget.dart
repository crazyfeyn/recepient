import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/recipe.dart';
import 'package:flutter_application/data/model/user_model.dart';
import 'package:flutter_application/data/services/recipes/firebase_recipe_service.dart';
import 'package:flutter_application/data/utils/app_constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

import '../../../widgets/toggleLike_widget.dart';
import '../../resipe_screens/recipe_details_screen.dart';

class TrippleWidget extends StatefulWidget {
  final List<Recipe> recipes;
  const TrippleWidget({super.key, required this.recipes});

  @override
  State<TrippleWidget> createState() => _TrippleWidgetState();
}

class _TrippleWidgetState extends State<TrippleWidget> {
  late List<Recipe> _filteredRecipes;

  @override
  void initState() {
    super.initState();
    _filteredRecipes = widget.recipes;
  }

  List<String> categories = [
    'All',
    'Latest',
    'Trending',
    'Short',
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
      case 3:
        _filteredRecipes
            .where((recipe) => recipe.estimatedTime.inMinutes <= 15)
            .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildUserGreeting(AppConstants.userModel),
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
        const Text(
          'All recipes',
          style: TextStyle(
            color: Color(0xFF1E1E1E),
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
                child: _buildRecipeCard(recipe),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecipeCard(Recipe recipe) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          height: 250,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(recipe.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Share.share('hello from Hogwarts'),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      'assets/images/share_icon.png',
                      height: 22,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        'assets/images/comment_icon.png',
                        height: 22,
                        color: const Color(0xFFFF9B05),
                      ),
                    ),
                    TogglelikeWidget(recipe: recipe),
                  ],
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.title,
                  style: const TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/time_icon.png',
                      height: 20,
                      color: const Color(0xFFFF9B05),
                    ),
                    Text(
                      ' ${recipe.estimatedTime.inMinutes} min',
                      style: const TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 20,
                      color: Color(0xFFFF9B05),
                    ),
                    Text(
                      ' ${recipe.rate}',
                      style: const TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/images/saved_icon.png',
                  height: 22,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserGreeting(UserModel? user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello ${user?.name ?? 'Guest'}',
              style: const TextStyle(
                color: Color(0xFF1E1E1E),
                fontWeight: FontWeight.w600,
                fontSize: 19,
              ),
            ),
            const Text(
              'What are you cooking today?',
              style: TextStyle(
                color: Color(0xFFA9A9A9),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
        Container(
          height: 47,
          width: 47,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: (user?.imageUrl == null || user!.imageUrl.isEmpty)
                  ? const AssetImage('assets/images/malfoy.png')
                      as ImageProvider
                  : NetworkImage(user!.imageUrl) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
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
}
