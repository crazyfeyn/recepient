import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IngredientsSectionWidget extends StatelessWidget {
  const IngredientsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size * 0.93,
                height: 210,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    _buildIngredientRow(
                      "Cooked rice (preferably day-old)",
                      "2 cups",
                    ),
                    const Divider(indent: 10, endIndent: 10),
                    _buildIngredientRow(
                      "Sausage, sliced",
                      "2 pcs",
                    ),
                    const Divider(indent: 10, endIndent: 10),
                    _buildIngredientRow(
                      "Garlic, minced",
                      "2 cloves",
                    ),
                    const Divider(indent: 10, endIndent: 10),
                    _buildIngredientRow(
                      "Small onion, chopped",
                      "1 pc",
                    ),
                    const Divider(indent: 10, endIndent: 10),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: (size / 2) - 65 / 2,
            child: Row(
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
      ),
    );
  }

  Widget _buildIngredientRow(String name, String quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: GoogleFonts.montserrat(fontSize: 12),
          ),
          Text(
            quantity,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
