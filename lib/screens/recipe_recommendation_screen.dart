import 'package:flutter/material.dart';
import 'package:recipe_recommendation/models/recipe.dart';
import 'package:recipe_recommendation/services/api_service.dart';
import 'package:recipe_recommendation/utils/app_gradients.dart';
import 'package:recipe_recommendation/widgets/recipe_recommendation/recipe_card.dart';

class RecipeRecommendationScreen extends StatefulWidget {
  final Set<String> selectedIngredients;
  const RecipeRecommendationScreen({
    super.key,
    required this.selectedIngredients,
  });

  @override
  State<RecipeRecommendationScreen> createState() =>
      _RecipeRecommendationScreenState();
}

class _RecipeRecommendationScreenState
    extends State<RecipeRecommendationScreen> {
  late Future<List<Recipe>> recipesFuture;

  @override
  void initState() {
    super.initState();
    recipesFuture = ApiService.fetchRecipes(widget.selectedIngredients);
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
          child: FutureBuilder<List<Recipe>>(
            future: recipesFuture,
            builder: (context, snapshot) {
              final count = snapshot.data?.length;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recipe Recommendations',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.connectionState == ConnectionState.waiting
                        ? 'Finding recipes...'
                        : snapshot.hasError
                        ? 'Could not load recipes'
                        : 'Found $count recipes',
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              );
            },
          ),
        ),
      ),

      body: FutureBuilder<List<Recipe>>(
        future: recipesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final recipes = snapshot.data!;

          if (recipes.isEmpty) {
            return const Center(child: Text("No Recipes Found!"));
          }

          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];

              return RecipeCard(
                title: recipe.title,
                imageUrl: recipe.imageUrl,
                missingIngredientCount: recipe.missingIngredientCount,
                missedIngredients: recipe.missedIngredients,
                usedIngredients: recipe.usedIngredients,
              );
            },
          );
        },
      ),
    );
  }
}
