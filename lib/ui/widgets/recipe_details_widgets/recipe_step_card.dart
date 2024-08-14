import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeStepCard extends StatelessWidget {
  final double size;

  const RecipeStepCard({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size * 0.93,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 10,
                        bottom: 5,
                      ),
                      child: Text(
                        "1. Preparation (5 Minutes)",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 10,
                        bottom: 5,
                      ),
                      child: Text(
                        "Cook the rice if not using leftover rice.",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 10,
                        bottom: 5,
                      ),
                      child: Text(
                        "Slice the sausages, mince the garlic, chop the onion, slice the chili, and dice the carrot.",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 10,
                        bottom: 5,
                      ),
                      child: Text(
                        "2. Cooking the Sausage (5 Minutes)",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 10,
                        bottom: 5,
                      ),
                      child: Text(
                        "Heat 1 tablespoon of vegetable oil in a large frying pan or wok over medium-high heat.",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: (size / 2) - 65 / 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "See More",
                style: GoogleFonts.montserrat(
                  color: Colors.orange,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
