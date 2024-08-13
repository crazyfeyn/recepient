import 'package:flutter/material.dart';
import 'package:flutter_application/ui/views/screens/add_new_retsept/widgets/review_widget.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({super.key});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: recipeCategories.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ReviewWidget();
                            },
                          ),
                        );
                      },
                      child: Text(
                        recipeCategories[index],
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
