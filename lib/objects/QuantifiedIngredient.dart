import 'package:healthying/objects/Ingredient.dart';
import 'package:healthying/objects/passive/Global.dart';

class QuantifiedIngredient {
  final int quantity;
  final bool optional;
  final Ingredient ingredient;
  final String additional;

  String get name => ingredient.name;

  IngredientCategory get category => ingredient.category;

  QuantifiedIngredient({this.quantity, this.optional, this.ingredient, this.additional});

  static QuantifiedIngredient fromMap(Map<String, dynamic> data) => (data == null || data.isEmpty)
      ? null
      : QuantifiedIngredient(
          quantity: data.containsKey('quantity') ? int.tryParse(data['quantity']) : DISABLED,
          optional: data.containsKey('optional'),
          ingredient: data.containsKey('category')
              ? Ingredient(name: data['name'], category: stringToIngredientCategory(data['category']))
              : Ingredient(name: data['name']),
          additional: data.containsKey('additional') ? data['additional'] : null);

  Map<String, dynamic> toMap() => {
        'quantity': quantity,
        'optional': optional,
        'name': name,
        'category': category,
        'additional': additional,
      };
}
