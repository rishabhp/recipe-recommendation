import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int missingIngredientCount;
  final Set<String> missedIngredients;
  final Set<String> usedIngredients;

  const RecipeCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.missingIngredientCount,
    required this.missedIngredients,
    required this.usedIngredients,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,

                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;

                      return const SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },

                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$missingIngredientCount Missing',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 12),

            if (usedIngredients.isNotEmpty) ...[
              const Text(
                "You Have: ",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
              Wrap(
                spacing: 6,
                children: usedIngredients
                    .map(
                      (ingredient) => Chip(
                        backgroundColor: Colors.green.shade50,
                        label: Text(
                          ingredient,
                          style: const TextStyle(color: Colors.green),
                        ),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 12),
            ],

            if (missedIngredients.isNotEmpty) ...[
              const Text(
                "You Are Missing: ",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
              Wrap(
                spacing: 6,
                children: missedIngredients
                    .map(
                      (ingredient) => Chip(
                        backgroundColor: Colors.red.shade50,
                        label: Text(
                          ingredient,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}
