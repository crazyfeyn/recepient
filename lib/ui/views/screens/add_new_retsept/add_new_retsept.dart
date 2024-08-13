import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/recipe.dart';
import 'package:flutter_application/ui/views/screens/add_new_retsept/widgets/recip_ingredients.dart';
import 'package:flutter_application/ui/views/screens/add_new_retsept/widgets/recipe_name.dart';
import 'package:flutter_application/ui/widgets/upload_image_widget%20.dart';
import 'package:gap/gap.dart';

class AddNewRecipe extends StatefulWidget {
  Recipe? recipe;
  AddNewRecipe({super.key, this.recipe});

  @override
  State<AddNewRecipe> createState() => _AddNewRecipeState();
}

class _AddNewRecipeState extends State<AddNewRecipe> {
  int activeStep = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Recipe"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            EasyStepper(
              activeStep: activeStep,
              activeStepBackgroundColor: const Color(0xffFF9B05),
              finishedStepBackgroundColor: const Color(0xffFF9B05),
              finishedStepIconColor: const Color(0xff00C337),
              enableStepTapping: false,
              lineStyle: LineStyle(
                lineThickness: 3,
                finishedLineColor: const Color(0xffFF9B05),
                defaultLineColor: Colors.grey.shade300,
                lineType: LineType.normal,
              ),
              stepRadius: 15,
              showLoadingAnimation: false,
              steps: [
                for (int i = 1; i < 6; i++)
                  EasyStep(
                    customStep: Text(
                      "$i",
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
              onStepReached: (index) => setState(() => activeStep = index),
            ),
            UploadImageWidget(),
            RecipIngredients(),
          ],
        ),
      ),
    );
  }
}
