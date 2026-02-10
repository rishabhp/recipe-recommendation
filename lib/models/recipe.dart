class Recipe {
  final int id;
  final String title;
  final String imageUrl;
  final int missingIngredientCount;
  final Set<String> missedIngredients;
  final Set<String> usedIngredients;

  const Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.missingIngredientCount,
    required this.missedIngredients,
    required this.usedIngredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as int,
      title: json['title'] as String,
      imageUrl: json['image'] as String,
      missingIngredientCount: json['missedIngredientCount'] as int,
      missedIngredients: (json['missedIngredients'] as List<dynamic>)
          .map((ingredient) => ingredient['name'] as String)
          .toSet(),
      usedIngredients: (json['usedIngredients'] as List<dynamic>)
          .map((ingredient) => ingredient['name'] as String)
          .toSet(),
    );
  }
}
