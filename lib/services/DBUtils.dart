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

  static Set<Ingredient> _everyIngredients = new Set();

  static Future<Set<Ingredient>> getEveryIngredients({IngredientCategory category}) async {
    if (DBUtils._everyIngredients.isEmpty) {
      print("> DB.getEveryIngredients()");
      if (database['ingredients'] is List) database['ingredients'].forEach((e) => DBUtils._everyIngredients.add(Ingredient.fromMap(e)));
      print("< DB.getEveryIngredients() with ${DBUtils._everyIngredients.length} elements");
      DBUtils._everyIngredients.forEach((e) => print(e));
    }
    return category != null ? DBUtils._everyIngredients.where((e) => e.category == category).toSet() : DBUtils._everyIngredients;
  }

  // TODO:
  static Future<List<Recipe>> getRecipesWithIngredients(Set<Ingredient> ingredients) async =>
      await Future.delayed(Duration(seconds: 2), () => List.empty());
}
