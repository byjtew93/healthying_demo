import 'package:flutter/material.dart';
import 'package:healthying/objects/Ingredient.dart';
import 'package:healthying/pages/RecipeListPage.dart';

class SearchDetailsPage extends StatefulWidget {
  final Set<Ingredient> details;

  SearchDetailsPage({@required this.details});

  @override
  State<StatefulWidget> createState() => _SearchDetailsPageState();
}

class _SearchDetailsPageState extends State<SearchDetailsPage> {
  _searchRecipes() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => RecipeListPage(ingredients: widget.details)));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        color: Colors.lightGreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.details.isEmpty
                ? Text("Nothing selected")
                : Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .02),
                      children: List.generate(
                        widget.details.length,
                        (index) => ListTile(title: Text(widget.details.elementAt(index).name)),
                      ),
                    ),
                  ),
            RaisedButton(
              onPressed: widget.details.isEmpty ? null : _searchRecipes,
              child: Text("Search recipes", style: TextStyle(fontSize: 30)),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            ),
          ],
        ),
      ),
    );
  }
}
