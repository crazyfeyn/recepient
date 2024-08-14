import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/comment.dart';
import 'package:flutter_application/data/model/ingredient.dart';
import 'package:flutter_application/data/model/recipe.dart';
import 'package:flutter_application/data/model/user_model.dart';

class ReviewWidget extends StatefulWidget {
  const ReviewWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReviewWidgetState createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  bool _isExpanded = false;

  Recipe recipe = Recipe(
    title: 'Chicken ramion',
    ingredient: [
      Ingredient(
          name: 'Chicken broth', quantity: 8, type: 'type', isSelected: false),
      Ingredient(
          name: 'Chicken somsa', quantity: 8, type: 'type', isSelected: false),
      Ingredient(name: 'Noodles', quantity: 2, type: 'type', isSelected: false),
      Ingredient(name: 'Garlic', quantity: 3, type: 'type', isSelected: false),
      Ingredient(name: 'Ginger', quantity: 1, type: 'type', isSelected: false),
    ],
    createdAt: DateTime.now(),
    description:
        'Est deserunt cupidatat irure esse esse.Duis Lorem occaecat officia velit amet duis excepteur in anim.',
    preparation: ['qwertytrewqwertre', 'qwertyhtrewsdcvfdfvfdfvfdedfvfdfvf'],
    estimatedTime: const Duration(minutes: 40),
    category: ['Asian', 'Nonoushta'],
    imageUrl: '',
    videoUrl: '',
    userId: '',
    id: '',
    isSaved: false,
    likes: [],
    rate: 5,
    comments: [
      Comment(
          rate: 0,
          user: UserModel(
              email: FirebaseAuth.instance.currentUser!.email!,
              name: '',
              imageUrl: '',
              uId: '',
              likes: [],
              saved: []),
          title: 'qwertyuiop')
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recipe Name',
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
                        'Estimated Time',
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
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ingredients',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      recipe.ingredient[index].name,
                                    ),
                                    Text(
                                      '${recipe.ingredient[index].quantity} cups',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemCount:
                                  _isExpanded ? recipe.ingredient.length : 4,
                            ),
                            if (recipe.ingredient.length > 4)
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isExpanded = !_isExpanded;
                                  });
                                },
                                child: Text(
                                  _isExpanded ? "View less" : "View more",
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'How to',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    const Text(
                                      '°',
                                    ),
                                    Text(
                                      recipe.preparation[index],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemCount: recipe.preparation.length,
                            ),
                            if (recipe.preparation.length > 4)
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isExpanded = !_isExpanded;
                                  });
                                },
                                child: Text(
                                  _isExpanded ? "View less" : "View more",
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: recipe.category.map(
                          (category) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.orange),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                category,
                                style: const TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w500),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
