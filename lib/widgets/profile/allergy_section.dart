import 'package:flutter/material.dart';
import 'package:recipe_recommendation/constants/popular_allergies.dart';

class AllergySection extends StatelessWidget {
  final Set<String> selectedAllergies;
  final Map<String, String> customAllergies;
  final void Function(
    Set<String> selectedAllergies,
    Map<String, String> customAllergies,
  )
  onChanged;

  const AllergySection({
    super.key,
    required this.selectedAllergies,
    required this.onChanged,
    required this.customAllergies,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, String> allEntries = {
      ...allergyLabels,
      ...customAllergies,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          children: [
            ...allEntries.entries.map((entry) {
              final allergy = entry.key;
              final displayText = entry.value;
              final bool isSelected =
                  selectedAllergies.contains(allergy) ||
                  customAllergies.keys.contains(allergy);

              return FilterChip(
                label: Text(displayText),
                selected: isSelected,
                selectedColor: const Color(0xFFE53935),
                backgroundColor: Colors.white,
                checkmarkColor: Colors.white,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                side: BorderSide(
                  color: isSelected
                      ? const Color(0xFFE53935)
                      : Colors.grey.shade300,
                ),
                onSelected: (_) {
                  final updatedSelected = Set<String>.from(selectedAllergies);
                  final updatedCustom = Map<String, String>.from(
                    customAllergies,
                  );

                  if (isSelected) {
                    updatedSelected.remove(allergy);
                    updatedCustom.remove(allergy);
                  } else {
                    if (allergyLabels.containsKey(allergy)) {
                      updatedSelected.add(allergy);
                    } else {
                      updatedCustom[allergy] = displayText;
                    }
                  }

                  onChanged(updatedSelected, updatedCustom);
                },
              );
            }),

            ActionChip(
              label: const Text('+ Add Allergy'),
              onPressed: () async {
                final allergyValue = await _addAllergyDialog(context);
                if (allergyValue == null) return;

                final String allergyKey = _normalizeAllergyInput(allergyValue);
                final updatedCustom = Map<String, String>.from(customAllergies);

                updatedCustom[allergyKey] = allergyValue;

                onChanged(selectedAllergies, updatedCustom);
              },
            ),
          ],
        ),

        SizedBox(height: 24),

        if (selectedAllergies.isNotEmpty || customAllergies.isNotEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFDECEA),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE53935), width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("You're Avoiding:"),
                SizedBox(height: 8),
                Text(
                  getSelectedIngredientDisplayTexts(
                    selectedAllergies,
                    customAllergies,
                  ).join(', '),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

Future<String?> _addAllergyDialog(BuildContext context) {
  final TextEditingController controller = TextEditingController();

  return showDialog<String>(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Add Allergy'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: 'e.g. Sesame Oil'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, controller.text.trim()),
          child: const Text('Add'),
        ),
      ],
    ),
  );
}

String _normalizeAllergyInput(String input) {
  return input
      .trim()
      .toLowerCase()
      .replaceAll(RegExp(r'\s+'), ' ')
      .replaceAll(RegExp(r'[^a-z0-9]'), '');
}

List<String> getSelectedIngredientDisplayTexts(
  Set<String> supportedAllergies,
  Map<String, String> customAllergies,
) {
  final result = <String>[];

  for (final key in supportedAllergies) {
    final label = allergyLabels[key];
    if (label != null) {
      result.add(label);
    }
  }
  result.addAll(customAllergies.values);

  return result;
}
