import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/controllers/recipe_controller.dart';
import 'package:flutter_application/data/model/recipe.dart';
import 'package:flutter_application/ui/views/screens/add_new_retsept/widgets/recip_ingredients.dart';
import 'package:flutter_application/ui/views/screens/add_new_retsept/widgets/recip_video.dart';
import 'package:flutter_application/ui/views/screens/add_new_retsept/widgets/recipe_name.dart';
import 'package:flutter_application/ui/views/screens/add_new_retsept/widgets/review_widget.dart';
import 'package:flutter_application/ui/widgets/upload_image_widget%20.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class AddNewRecipe extends StatefulWidget {
  final Recipe? recipe;

  AddNewRecipe({Key? key, this.recipe}) : super(key: key);

  @override
  State<AddNewRecipe> createState() => _AddNewRecipeState();
}

class _AddNewRecipeState extends State<AddNewRecipe> {
  final PageController _pageController = PageController();
  int activeStep = 0;

  final List<Widget> create = [
    RecipeName(),
    RecipeStepsWidget(),
    VideoUploadWidget(),
    ReviewWidget(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecipeAddController(
        pageController: _pageController,
      ),
      child: Scaffold(
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
                enableStepTapping: true,
                lineStyle: LineStyle(
                  lineThickness: 3,
                  finishedLineColor: const Color(0xffFF9B05),
                  defaultLineColor: Colors.grey.shade300,
                  lineType: LineType.normal,
                ),
                stepRadius: 15,
                showLoadingAnimation: false,
                steps: List.generate(
                  create.length,
                  (index) => EasyStep(
                    customStep: Text(
                      "${index + 1}",
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onStepReached: (index) {
                  setState(() => activeStep = index);
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              const Gap(20),
              UploadImageWidget(),
              const Gap(10),
              SizedBox(
                height: 400, // Adjust based on your content height
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: create.length,
                  onPageChanged: (index) {
                    setState(() {
                      activeStep = index;
                    });
                  },
                  itemBuilder: (context, index) => create[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
