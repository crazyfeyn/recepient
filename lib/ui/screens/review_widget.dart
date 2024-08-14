import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/comment.dart';
import 'package:flutter_application/data/model/ingredient.dart';
import 'package:flutter_application/data/model/recipe.dart';
import 'package:flutter_application/data/model/user_model.dart';
import 'package:flutter_application/data/services/user/firebase_user_service.dart';

class ReviewWidget extends StatelessWidget {
  ReviewWidget({super.key});

  Recipe recipe = Recipe(
    title: 'Chicken ramion',
    ingredient: [
      Ingredient(
          name: 'Chicken broth', quantity: 8, type: 'type', isSelected: false),
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
    likes: 0,
    rate: 5,
    comments: [],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
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
            ],
          ),
        ),
      ),
    );
  }
}
