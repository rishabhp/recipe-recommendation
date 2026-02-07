import 'package:flutter/material.dart';

class AddIngredientsTitle extends StatelessWidget {
  const AddIngredientsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Text(
        "Add Your Ingredients",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
