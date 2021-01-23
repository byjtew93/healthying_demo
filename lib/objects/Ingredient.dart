import 'package:flutter/material.dart';
import 'package:healthying/objects/passive/QuantifiableIngredient.dart';

class Ingredient extends QuantifiableIngredient {
  final String name;
  final IngredientCategory category;

  Ingredient({this.name, this.category}) : super();

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

  @override
  String toString() {
    return 'Ingredient{name: $name, category: ${category.toCorrectString()}}';
  }
}

enum IngredientCategory { VEGETABLE, FRUIT, MEAT, FISH, SPICE, LIQUID, OTHER }

extension IngredientCategoryExtension on IngredientCategory {
  String toCorrectString() => this.toString().substring(19);

  Color toColor() {
    switch (this) {
      case IngredientCategory.FRUIT:
        return Colors.yellow;
      case IngredientCategory.VEGETABLE:
        return Colors.lightGreen;
      case IngredientCategory.MEAT:
        return Colors.red;
      case IngredientCategory.FISH:
        return Colors.blueAccent;
      case IngredientCategory.SPICE:
        return Colors.orangeAccent;
      case IngredientCategory.LIQUID:
        return Colors.lightBlueAccent.withOpacity(.5);
      default:
        return Colors.white;
    }
  }

  Image toIcon() => Image.asset(
        'assets/icons/${this.toCorrectString().toLowerCase()}.png',
        color: Colors.white,
      );
}

List<String> getIngredientCategoryStringList() => IngredientCategory.values.map((e) => e.toString()).toList();

IngredientCategory stringToIngredientCategory(String category) {
  switch (category.trim().toUpperCase()) {
    case "FRUIT":
      return IngredientCategory.FRUIT;
    case "VEGETABLE":
      return IngredientCategory.VEGETABLE;
    case "MEAT":
      return IngredientCategory.MEAT;
    case "FISH":
      return IngredientCategory.FISH;
    case "SPICE":
      return IngredientCategory.SPICE;
    case "LIQUID":
      return IngredientCategory.LIQUID;
    default:
      return IngredientCategory.OTHER;
  }
}
