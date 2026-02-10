import 'package:recipe_recommendation/constants/diet_types.dart';

class UserPreferences {
  final DietTypes dietType;
  final Set<String> intolerances;
  final Map<String, String> customRestrictions;

  const UserPreferences({
    required this.dietType,
    required this.intolerances,
    required this.customRestrictions,
  });

  factory UserPreferences.fromFirestore(Map<String, dynamic> data) {
    return UserPreferences(
      dietType: DietTypes.values.firstWhere(
        (e) => e.name == (data['dietType'] ?? 'nonveg'),
      ),
      intolerances: Set<String>.from(data['intolerances'] ?? const []),
      customRestrictions: Map<String, String>.from(data['customRestrictions'] ?? const {}),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'dietType': dietType.name,
      'intolerances': intolerances.toList(),
      'customRestrictions': customRestrictions
    };
  }
}
