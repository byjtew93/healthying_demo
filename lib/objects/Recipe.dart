import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:healthying/objects/QuantifiedIngredient.dart';
import 'package:healthying/objects/RecipeStep.dart';
import 'package:healthying/objects/passive/Bloc.dart';

class Recipe {
  Bloc<Recipe> _bloc;

  Bloc<Recipe> get bloc => _bloc;

  final List<RecipeStep> steps;
  final List<QuantifiedIngredient> ingredients;
  final Set<RecipeCategory> categories;
  final Set<RecipeTag> tags;
  final String name;

  Recipe({this.name, this.steps, this.ingredients, this.categories, this.tags}) {
    _bloc = Bloc.of(this);
    _bloc.update();
  }

  static Recipe fromMap(Map<String, dynamic> data) {
    if (data == null || data.isEmpty) return null;
    Set<RecipeCategory> categories = Set();
    if (data.containsKey('categories') && data['categories'] is Iterable)
      data['categories'].forEach((e) => categories.add(stringToRecipeCategory(e)));
    Set<RecipeTag> tags = Set();
    if (data.containsKey('tags') && data['tags'] is Iterable) data['tags'].forEach((e) => tags.add(stringToRecipeTag(e)));
    return Recipe(
      name: data['name'],
      steps: data['steps'] is Iterable
          ? List.generate(data['steps'].length, (index) => RecipeStep.fromMap(data['steps'].elementAt(index)))
          : List(),
      ingredients: data['ingredients'] is Iterable
          ? List.generate(data['ingredients'].length, (index) => QuantifiedIngredient.fromMap(data['ingredients'].elementAt(index)))
          : List(),
      categories: categories,
      tags: tags,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'steps': steps.map((e) => e.toMap()).toList(),
        'ingredients': ingredients.map((e) => e.toMap()).toList(),
        'categories': categories.map((e) => e.toCorrectString()).toList(),
        'tags': tags.map((e) => e.toCorrectString()).toList(),
      };

  Widget endView(Size size) => Container(
        child: Text(
          'END',
          textAlign: TextAlign.center,
        ),
      );

  @override
  String toString() {
    return 'Recipe{steps: $steps, ingredients: $ingredients, categories: $categories, tags: $tags, name: $name}';
  }
}

enum RecipeCategory { APPETIZER, DESSERT, MAIN, SALAD, BAKERY, DRINK }

extension RecipeCategoryExtension on RecipeCategory {
  String toCorrectString() => this.toString().substring(15);
}

RecipeCategory stringToRecipeCategory(String category) {
  switch (category.toUpperCase()) {
    case "APPETIZER":
      return RecipeCategory.APPETIZER;
    case "DESSERT":
      return RecipeCategory.DESSERT;
    case "MAIN":
      return RecipeCategory.MAIN;
    case "SALAD":
      return RecipeCategory.SALAD;
    case "BAKERY":
      return RecipeCategory.BAKERY;
    default:
      return RecipeCategory.DRINK;
  }
}

enum RecipeTag { HEALTHY, VEGGIE, VEGAN, QUANTITY, PARTY, ALCOHOL }

extension RecipeTagExtension on RecipeTag {
  String toCorrectString() => this.toString().substring(10);
}

RecipeTag stringToRecipeTag(String tag) {
  switch (tag.toUpperCase()) {
    case "HEALTHY":
      return RecipeTag.HEALTHY;
    case "VEGGIE":
      return RecipeTag.VEGGIE;
    case "VEGAN":
      return RecipeTag.VEGAN;
    case "QUANTITY":
      return RecipeTag.QUANTITY;
    case "PARTY":
      return RecipeTag.PARTY;
    default:
      return RecipeTag.ALCOHOL;
  }
}
