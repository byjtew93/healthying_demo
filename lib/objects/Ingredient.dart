import 'package:flutter/material.dart';
import 'package:healthying/objects/passive/SelectableItem.dart';

class Ingredient extends SelectableItem {
  final String name;
  final IngredientCategory category;

  Ingredient({this.name, this.category});

  static Ingredient fromMap(Map<String, dynamic> data) => (data == null || data.isEmpty)
      ? null
      : Ingredient(
          name: data['name'],
          category: stringToIngredientCategory(data['category']),
        );

  Map<String, dynamic> toMap() => {
        'name': name,
        'category': category.toCorrectString(),
      };

  Image get image => Image.asset('assets/images/' + name.toLowerCase().replaceAll(' ', '_') + '.png');
}

enum IngredientCategory { FRUIT, VEGETABLE, MEAT, SPICE, LIQUID, OTHER }

extension IngredientCategoryExtension on IngredientCategory {
  String toCorrectString() => this.toString().substring(19);
}

IngredientCategory stringToIngredientCategory(String category) {
  switch (category.toUpperCase()) {
    case "FRUIT":
      return IngredientCategory.FRUIT;
    case "VEGETABLE":
      return IngredientCategory.VEGETABLE;
    case "MEAT":
      return IngredientCategory.MEAT;
    case "SPICE":
      return IngredientCategory.SPICE;
    case "LIQUID":
      return IngredientCategory.LIQUID;
    default:
      return IngredientCategory.OTHER;
  }
}
