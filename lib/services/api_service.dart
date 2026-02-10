import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_recommendation/constants/env.dart';
import 'package:recipe_recommendation/models/recipe.dart';

class ApiService {

  static Future<List<Recipe>> fetchRecipes (Set<String> ingredients) async {
    final url = Uri.https(Env.apiUrl, '/recipes/findByIngredients', {
      'apiKey': Env.apiKey,
      'ingredients': ingredients.join(',').toLowerCase(),
      'number': '10',
      'ranking': '1',
      'ignorePantry': 'true',
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Recipe.fromJson(e)).toList();
    } else {
      throw Exception(
        "Failed to fetch recipes (${response.statusCode})"
      );
    }
  }
}