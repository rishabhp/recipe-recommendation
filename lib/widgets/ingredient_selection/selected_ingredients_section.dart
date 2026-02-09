import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectedIngredientsSection extends StatelessWidget {
  final Set<String> selectedIngredients;
  final void Function(String ingredient) onRemove;

  const SelectedIngredientsSection({
    super.key,
    required this.selectedIngredients,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedIngredients.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFDECEA),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE53935), width: 1.5),
        ),
        child: const Text(
          "No ingredients selected.",
        ),
      );
    }

    return Wrap(
      spacing: 12,
      children: selectedIngredients.map((ingredient) {
        return InputChip(
          label: Text(ingredient),
          onDeleted: () => onRemove(ingredient),
        );
      }).toList(),
    );
  }
}
