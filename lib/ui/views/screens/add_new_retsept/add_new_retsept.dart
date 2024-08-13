import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/recipe.dart';
import 'package:flutter_application/ui/widgets/upload_image_widget%20.dart';

class AddNewRetsept extends StatefulWidget {
  Recipe? recipe;
  AddNewRetsept({super.key, this.recipe});

  @override
  State<AddNewRetsept> createState() => _AddNewRetseptState();
}

class _AddNewRetseptState extends State<AddNewRetsept> {
  int activeStep = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Recipe"),
      ),
      body: Column(
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
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
