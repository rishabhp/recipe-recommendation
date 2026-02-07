import 'package:flutter/material.dart';
import 'package:recipe_recommendation/widgets/icon_box.dart';

class ManuallyAddIngredient extends StatelessWidget {
  const ManuallyAddIngredient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        border: BoxBorder.all(color: Colors.deepOrange, width: 1.5),
        borderRadius: BorderRadius.circular(28),
      ),
    
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconBox(
            icon: Icons.add,
            backgroundColor: Colors.orange.shade100,
            iconColor: Colors.deepOrange,
            size: 64,
            iconSize: 42,
            radius: 18,
          ),
    
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Manually",
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
              Text(
                "Type Ingredients Yourself",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),
    
          SizedBox(width: 42,)
        ],
      ),
    );
  }
}
