import 'package:flutter/material.dart';
import 'package:recipe_recommendation/screens/recipe_recommendation_screen.dart';

class BottomFindRecipeBar extends StatelessWidget {
  final Set<String> selectedIngredients;
  const BottomFindRecipeBar({super.key, required this.selectedIngredients});

  @override
  Widget build(BuildContext context) {
    final count = selectedIngredients.length;
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(),

          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  count < 3
                      ? 'Select at least 3 ingredients'
                      : "Ready to find recipes with $count ingredients",
                  style: TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  height: 52,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),

                    onPressed: count < 3
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RecipeRecommendationScreen(
                                  selectedIngredients: selectedIngredients,
                                ),
                              ),
                            );
                          },
                    child: Text(
                      "Find Recipes",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
