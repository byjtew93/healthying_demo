import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthying/objects/Ingredient.dart';
import 'package:healthying/objects/Recipe.dart';
import 'package:healthying/services/DBUtils.dart';

class RecipeListPage extends StatefulWidget {
  final Set<Ingredient> ingredients;

  RecipeListPage({this.ingredients});

  @override
  State<StatefulWidget> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: FutureBuilder(
          future: DBUtils.getRecipesWithIngredients(widget.ingredients),
          builder: (context, AsyncSnapshot<List<Recipe>> snap) {
            if (snap.hasError) {
              print(snap.error);
              return Center(child: Icon(Icons.error, color: Colors.red));
            } else if (!snap.hasData)
              return Center(child: CupertinoActivityIndicator());
            else
              return Center(child: Icon(Icons.assignment_turned_in_outlined, color: Colors.green));
          },
        ),
      ),
    );
  }
}
