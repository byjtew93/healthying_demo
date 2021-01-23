import 'package:flutter/material.dart';
import 'package:healthying/objects/Ingredient.dart';
import 'package:healthying/pages/searchpage/SearchPage.dart';
import 'package:healthying/widgets/DetailGridItem.dart';

class SearchPageCategoryInner extends StatelessWidget {
  final SearchPage searchPage;
  final Set<Ingredient> ingredients;
  final IngredientCategory category;

  const SearchPageCategoryInner(this.searchPage, this.ingredients, this.category, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: category.toColor(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(category.toCorrectString()),
          ),
          SizedBox(
            height: ((ingredients.length) / 2).round() * (MediaQuery.of(context).size.width / 2),
            child: GridView(
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                ingredients.length,
                (index) => GestureDetector(
                  onTap: () => searchPage.toggleSelected(ingredients.elementAt(index)),
                  child: DetailGridItem(ingredient: ingredients.elementAt(index)),
                ),
              ),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                childAspectRatio: 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
