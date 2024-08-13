import 'package:flutter/material.dart';

class RecipIngredients extends StatefulWidget {
  const RecipIngredients({super.key});

  @override
  State<RecipIngredients> createState() => _RecipIngredientsState();
}

class _RecipIngredientsState extends State<RecipIngredients> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
