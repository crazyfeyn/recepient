import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/recipe.dart';
import 'package:flutter_application/data/services/recipes/firebase_recipe_service.dart';
import 'package:flutter_application/ui/screens/home_screen/widgets/book_mark_widget.dart';
import 'package:flutter_application/ui/widgets/toggleLike_widget.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class BuildRecipeCardWidget extends StatelessWidget {
  Recipe recipe;
  BuildRecipeCardWidget({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
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
                  style: TextStyle(
                    color: AdaptiveTheme.of(context).mode ==
                                AdaptiveThemeMode.light ||
                            AdaptiveTheme.of(context).mode ==
                                AdaptiveThemeMode.system
                        ? Colors.black
                        : Colors.white,
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
                      style: TextStyle(
                        color: AdaptiveTheme.of(context).mode ==
                                    AdaptiveThemeMode.light ||
                                AdaptiveTheme.of(context).mode ==
                                    AdaptiveThemeMode.system
                            ? Colors.black
                            : Colors.white,
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
                      style: TextStyle(
                        color: AdaptiveTheme.of(context).mode ==
                                    AdaptiveThemeMode.light ||
                                AdaptiveTheme.of(context).mode ==
                                    AdaptiveThemeMode.system
                            ? Colors.black
                            : Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const BookMarkWidget()
          ],
        ),
      ],
    );
  }
}
