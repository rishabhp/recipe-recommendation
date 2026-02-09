import 'package:flutter/material.dart';
import 'package:recipe_recommendation/constants/ingredient_source.dart';
import 'package:recipe_recommendation/utils/app_gradients.dart';
import 'package:recipe_recommendation/widgets/ingredient_selection/add_ingredient_section.dart';
import 'package:recipe_recommendation/widgets/ingredient_selection/bottom_find_recipe_bar.dart';
import 'package:recipe_recommendation/widgets/ingredient_selection/selected_ingredients_section.dart';

class IngredientSelectionScreen extends StatefulWidget {
  final Set<String> initialIngredients;
  final IngredientSource ingredientSource;

  const IngredientSelectionScreen({
    super.key,
    required this.initialIngredients,
    required this.ingredientSource,
  });

  @override
  State<IngredientSelectionScreen> createState() =>
      _IngredientSelectionScreenState();
}

class _IngredientSelectionScreenState extends State<IngredientSelectionScreen> {
  late Set<String> selectedIngredients;

  @override
  void initState() {
    super.initState();
    selectedIngredients = Set.from(widget.initialIngredients);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,

        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppGradients.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
        ),

        title: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.ingredientSource == IngredientSource.camera
                    ? 'Detected Ingredients'
                    : 'Your Ingredients',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.ingredientSource == IngredientSource.camera
                    ? 'Review and edit the ingredients we found'
                    : 'Add ingredients to get recipe ideas',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),

            Text(
              "Your Ingredient (${selectedIngredients.length})",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6.0,),

            SelectedIngredientsSection(
              selectedIngredients: selectedIngredients,
              onRemove: (String ingredient) {
                setState(() {
                  selectedIngredients.remove(ingredient);
                });
              },
            ),

            const SizedBox(height: 32,),

            Text(
              widget.ingredientSource == IngredientSource.camera
              ? 'Add Anything We Missed'
              : 'Add Your Ingredients',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6,),

            AddIngredientSection(onAdd: (newIngredient) {
              setState(() {
                selectedIngredients.add(newIngredient);
              });
            })
          ],
        ),
      ),

      bottomNavigationBar: BottomFindRecipeBar(selectedIngredients: selectedIngredients),
    );
  }
}
