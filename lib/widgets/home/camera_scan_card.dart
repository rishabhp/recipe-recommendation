import 'package:flutter/material.dart';
import 'package:recipe_recommendation/constants/ingredient_source.dart';
import 'package:recipe_recommendation/screens/ingredient_selection_screen.dart';
import 'package:recipe_recommendation/utils/app_gradients.dart';
import 'package:recipe_recommendation/widgets/icon_box.dart';

class CameraScanCard extends StatelessWidget {
  const CameraScanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => IngredientSelectionScreen(
                initialIngredients: {'Potato', 'Onion', 'Spinach'},
                ingredientSource: IngredientSource.camera,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(28),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            gradient: AppGradients.primary,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBox(
                icon: Icons.camera_alt_outlined,
                backgroundColor: Colors.white24,
                iconColor: Colors.white,
                size: 64,
                iconSize: 42,
                radius: 18,
              ),
      
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Scan Ingredients",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  Text(
                    "Take a photo to detect",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
      
              Icon(Icons.file_upload_outlined, size: 42, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
