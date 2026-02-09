import 'package:flutter/material.dart';
import 'package:recipe_recommendation/constants/diet_types.dart';
import 'package:recipe_recommendation/widgets/profile/dietary_preference_card.dart';

class DietaryPreferenceSection extends StatelessWidget {
  final DietTypes selectedDiet;
  final ValueChanged<DietTypes> onChanged;

  const DietaryPreferenceSection({
    super.key,
    required this.selectedDiet,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DietaryPreferenceCard(
          label: 'Vegetarian',
          icon: const Text('🥗', style: TextStyle(fontSize: 40)),
          isSelected: selectedDiet == DietTypes.veg,
          onTap: () {
            onChanged(DietTypes.veg);
          },
          selectedBorderColor: const Color(0xFF4CAF50),
          selectedBackgroundColor: const Color(0xFFF3FBF3),
        ),

        DietaryPreferenceCard(
          label: 'Non-Vegetarian',
          icon: const Text('🍖', style: TextStyle(fontSize: 40)),
          isSelected: selectedDiet == DietTypes.nonveg,
          onTap: () {
            onChanged(DietTypes.nonveg);
          },
          selectedBorderColor: const Color(0xFFE53935),
          selectedBackgroundColor: const Color(0xFFFDECEA),
        ),
      ],
    );
  }
}
