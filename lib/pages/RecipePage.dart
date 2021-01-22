import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthying/objects/Recipe.dart';
import 'package:healthying/pages/StepPage.dart';

class RecipePage extends StatefulWidget {
  final Recipe recipe;

  RecipePage(this.recipe);

  @override
  State<StatefulWidget> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  void initState() {
    super.initState();
    print(widget.recipe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder(
            stream: widget.recipe.bloc.stream,
            builder: (context, AsyncSnapshot<Recipe> snap) => snap.hasData && !snap.hasError
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.recipe.steps.length,
                    itemBuilder: (context, index) => widget.recipe.steps.elementAt(index).card,
                  )
                : CupertinoActivityIndicator(),
          ),
          RaisedButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => StepPage(recipe: widget.recipe))),
          ),
        ],
      ),
    );
  }
}
