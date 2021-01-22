import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:healthying/objects/Ingredient.dart';
import 'package:healthying/objects/Recipe.dart';

abstract class DBUtils {
  static String _db;

  static Map<String, dynamic> get database => json.decode(_db);

  static Future<void> init() async {
    _db = await rootBundle.loadString('assets/db.json');
    print("\nBD:\n$database\n\n");
  }

  static Future<Recipe> getRecipe(String id) async =>
      database['recipes'] is Map && database['recipes'].containsKey(id) ? Recipe.fromMap(database['recipes'][id]) : null;

  static Future<List<Ingredient>> getEveryIngredients() async {
    List<Ingredient> ingredients = List();
    if (database['ingredients'] is List) database['ingredients'].forEach((e) => ingredients.add(Ingredient.fromMap(e)));
    return ingredients;
  }

  // TODO:
  static Future<List<Recipe>> getRecipesWithIngredients(List<Ingredient> ingredients) async =>
      await Future.delayed(Duration(seconds: 2), () => List.empty());
}
